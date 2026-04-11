Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB35632E6B8;
	Sat, 11 Apr 2026 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775902346; cv=none; b=GM9QcZBZNfpJw97fELZEQqul1MOLWm7uBvXrv0GdaqrCzSbjX6aW95FiTleA8LcAZiG1pxuTEWT+OmXRcDAKRrLT42+prLayz1leirbfQ9Rlk1bVzPP3Dv9QJunnpi2W3ANXCuwebgKEkLecEv73gLhfa+bPmL/0pwUOHzpVrqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775902346; c=relaxed/simple;
	bh=xeOwmbvZi8iIq2Y68tN3V7TkwozyYLvVfG0YS4MKjmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NcM6Xe5HImkCj43xBVcKEqvoHcyIj0caALvN5Sd9SVxWYtNqbGg4ee1RVGyAUcCN3/wptMCxr7U1uKnjH3VFb1pp7cnDpR3M0CegZhC5e3BCDYkioPwxtnofekJxuFUVE5br7ZX4K4RacZB1xUr0M8Lha0Y5k26K+tGuyj0YNkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vvay9Ig4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vvay9Ig4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7CFC4CEF7;
	Sat, 11 Apr 2026 10:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775902346;
	bh=xeOwmbvZi8iIq2Y68tN3V7TkwozyYLvVfG0YS4MKjmE=;
	h=From:To:Cc:Subject:Date:From;
	b=Vvay9Ig4a2bEcyW7Z9ihyHzvIUEMxYpQ5kgkYCDsEnb4w7ZEQZFHRgtaKwdlO8O1R
	 N8+RCgYmk+Y9s+s0loppd7EMwaN04ULgLgHgjO1PT4xOtT7P36/avFyshkMe6EwM1q
	 yPRwb13JRrYIBFE2F2kdH1VsKQTTINhBNi9eStxY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable <stable@kernel.org>
Subject: [PATCH net] idpf: fix double free and use-after-free in aux device error paths
Date: Sat, 11 Apr 2026 12:12:16 +0200
Message-ID: <2026041116-retail-bagginess-250f@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2515; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=xeOwmbvZi8iIq2Y68tN3V7TkwozyYLvVfG0YS4MKjmE=; b=owGbwMvMwCRo6H6F97bub03G02pJDJm35BoMVPK/975pV2ZLmDXZcP3bci394zuzu/2Y028un 8mgLZbbEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABOpYGGYp1D2SnfW/x/MmhI7 Lt18H1SwwNGugmGuzEMf+63x0UrFuzg3CrVkVpbee54PAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

When auxiliary_device_add() fails in idpf_plug_vport_aux_dev() or
idpf_plug_core_aux_dev(), the err_aux_dev_add label calls
auxiliary_device_uninit() and falls through to err_aux_dev_init.  The
uninit call will trigger put_device(), which invokes the release
callback (idpf_vport_adev_release / idpf_core_adev_release) that frees
iadev.  The fall-through then reads adev->id from the freed iadev for
ida_free() and double-frees iadev with kfree().

Free the IDA slot and clear the back-pointer before uninit, while adev
is still valid, then return immediately.

Commit 65637c3a1811 65637c3a1811 ("idpf: fix UAF in RDMA core aux dev
deinitialization") fixed the same use-after-free in the matching unplug
path in this file but missed both probe error paths.

Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: stable <stable@kernel.org>
Fixes: be91128c579c ("idpf: implement RDMA vport auxiliary dev create, init, and destroy")
Fixes: f4312e6bfa2a ("idpf: implement core RDMA auxiliary dev create, init, and destroy")
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, these cleanup paths are messy, but I couldn't see a simpler way
without a lot more rework, so I choose the simple way :)

 drivers/net/ethernet/intel/idpf/idpf_idc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index 7e4f4ac92653..b7d6b08fc89e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -90,7 +90,10 @@ static int idpf_plug_vport_aux_dev(struct iidc_rdma_core_dev_info *cdev_info,
 	return 0;
 
 err_aux_dev_add:
+	ida_free(&idpf_idc_ida, adev->id);
+	vdev_info->adev = NULL;
 	auxiliary_device_uninit(adev);
+	return ret;
 err_aux_dev_init:
 	ida_free(&idpf_idc_ida, adev->id);
 err_ida_alloc:
@@ -228,7 +231,10 @@ static int idpf_plug_core_aux_dev(struct iidc_rdma_core_dev_info *cdev_info)
 	return 0;
 
 err_aux_dev_add:
+	ida_free(&idpf_idc_ida, adev->id);
+	cdev_info->adev = NULL;
 	auxiliary_device_uninit(adev);
+	return ret;
 err_aux_dev_init:
 	ida_free(&idpf_idc_ida, adev->id);
 err_ida_alloc:
-- 
2.53.0

