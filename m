Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234D93B8BCC
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163935; cv=none; b=lBx7JT+PPHR5l6TPoyWjqprzz46ey2OD/rnOimJzb/uoqu0qLKjmQTWnZuxokt7jYfLhTTj+6HGKSTTwb4BkFFXq5cvOxcHiRhsx/hglUNKOhDs19ZScLP+WLLynH6PrAzO5ENG8OojnToHk6DFJWXkfcIF3atmsnEoY/OhfP1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163935; c=relaxed/simple;
	bh=S7oVTSvogG7USfwTxMfEOD+Uu0n9c+HcXh1kMkQ3bk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gGb2+Tt2vQgebjTPwqSzEh9YQnUTztL2U3p5DGwLydRM0sRcdOHTXFpmY20sqqlho2aYo4rXp1XUr9NcLJtPWNqf6/YBKohVwqPli44EROkxLj2x4jPto84Y6/YrC1huLily6lyhwzdUSgkiI/p+C7ULj48EiitchSFm4mNKJVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vv/UJXa3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vv/UJXa3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC571F000E9;
	Mon, 31 Aug 2026 08:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788163933;
	bh=6ZruAq+CcKNWQQ1lcvj+7xRjhbf/EImGV+u+yCHjVz4=;
	h=From:Date:Subject:To:Cc;
	b=Vv/UJXa3ctUTebEBFo50aWj1d0cjliuEbe8EbF50u5YM/u7PFr6g8jI70f9NUwBAp
	 LLgxT57nb48p2t0wi6ISZky9DmgBNQXzchrDqmvu4x31p6WmF7VAsbEJnLFG06hpVj
	 sVfo3J+gDcSbbnig6XTux8AmZiGpTP1ft4Ap4PZo6cbh5Vnc1kF90fIRK6m741P2yh
	 npmtA8qRMcJvgxX8oUy0a9UJd5CesllHW++7cIuZKYpeXDAa9AYau04Z/NeGhW4Yiw
	 JmYhsc311qVck2F5Jmb7G2LV2e+3Hcm7nSSBTvCQ1KjLRXM0R8QPL7zffBu3kUVtIF
	 AC354m70/6/pA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 31 Aug 2026 10:11:50 +0200
Subject: [PATCH net-next] mailmap: add entries for Lorenzo Bianconi
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-lorenzo-mailmap-v1-1-c6361ef1eeb3@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBG4avIrDuQRKjWq0gXof6pAzqRRCRUv
 HuDy2/x3kkZSZBpaE5KOCRL1Ar7aOgze/2CZaomZ9zT9K3lJSboL/LqZVn9xuhsh2Da4F6BarU
 lBCn3cSTFzoqy0/u6/ns6O8ZrAAAA
X-Change-ID: 20260831-lorenzo-mailmap-e717ef03f29f
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.3

Add the active email address for Lorenzo Bianconi and map the old,
no-longer-used addresses to it, so that git can attribute his
contributions to a single identity.
This is done to avoid bouncing emails sent to email addresses that are
no longer active.

---
 .mailmap | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.mailmap b/.mailmap
index 8fb9f3898d7a..39b77eb2db87 100644
--- a/.mailmap
+++ b/.mailmap
@@ -546,6 +546,9 @@ Li Yang <leoyang.li@nxp.com> <leo@zh-kernel.org>
 Lior David <quic_liord@quicinc.com> <liord@codeaurora.org>
 Loic Poulain <loic.poulain@oss.qualcomm.com> <loic.poulain@linaro.org>
 Loic Poulain <loic.poulain@oss.qualcomm.com> <loic.poulain@intel.com>
+Lorenzo Bianconi <lorenzo@kernel.org> <lorenzo.bianconi@redhat.com>
+Lorenzo Bianconi <lorenzo@kernel.org> <lorenzo.bianconi@st.com>
+Lorenzo Bianconi <lorenzo@kernel.org> <lorenzo.bianconi83@gmail.com>
 Lorenzo Pieralisi <lpieralisi@kernel.org> <lorenzo.pieralisi@arm.com>
 Lorenzo Stoakes <ljs@kernel.org> <lstoakes@gmail.com>
 Lorenzo Stoakes <ljs@kernel.org> <lorenzo.stoakes@oracle.com>

---
base-commit: 1bb784eb6e38fd73143f021608e4ef3095d0c0d7
change-id: 20260831-lorenzo-mailmap-e717ef03f29f

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

