Received: from sender-pp-o93.zoho.in (sender-pp-o93.zoho.in [103.117.158.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFED53537FE;
	Fri, 22 May 2026 06:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779432811; cv=pass; b=oLjxSYtxdVJpnSv/eAt4QuZtlJ/s4TGNy6Ow/VqX/OnaTE6UnWuSVND6BdBuplIYxwNY5ZFvVHpcPs8M2/hFGvTbnpCoKgCJyEORLH1bnJvrOr5u5+oa51bBlBCfVgYcE1kS0/rLqLu0VDmydWEg8VBHQ8p8KiEPsF4KfY5UM1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779432811; c=relaxed/simple;
	bh=BjQT+YwVFJIg+6eKHraFXkbmCcLFw8BYQEDz4dPV4Q0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=Kk3pFT/75e3x364Q8NDD4NAXjttCFp+JDkr4lg+eTk/V49++VhhqczDgG0OYTLotBFnvMW2I8jyy5XCkQ+/ntFnJ7tgjXSg+vDVyfuuw49NrWEljcZJil2e+AJHUbzeUWOZNDcJdo3KF43C3QnMZ5eMXLaMpMgjG2ijk3hY6/c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b=SERrZCjK; arc=pass smtp.client-ip=103.117.158.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b="SERrZCjK"
ARC-Seal: i=1; a=rsa-sha256; t=1779432756; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=UkXkWLLdEfqXd6g0Ptcz/gbq5B435B2CfehOEPGruFLBmSjNJTb8NQGdkFmSVkGab/1hzHICaKxIkV5Y5vlZYABlVXkKLeaAzjMuScE7aj8z6VXm+l0M2q5QCLcRJ3pKpP8JWDijTseFhemviOa4APjfds6dugmILgQlOiG19JU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1779432756; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BjQT+YwVFJIg+6eKHraFXkbmCcLFw8BYQEDz4dPV4Q0=; 
	b=ZpT85IrCGhWvMjEAbGJwJGMMKGpR74koJVZOSR53bJXr1yciwsqYR038e9DDU/CoMGhuysuJfGK79+jKOfUIUhgoPCYvDYA3L8f9NPaF/LQH4eVNdE2IFlVfOu7/b78sBaW9EVjmnknSC9YLw05jGJGkWnH2p2c7fndxYKOeVPM=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=linuxuser509@zohomail.in;
	dmarc=pass header.from=<linuxuser509@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779432756;
	s=zoho; d=zohomail.in; i=linuxuser509@zohomail.in;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=BjQT+YwVFJIg+6eKHraFXkbmCcLFw8BYQEDz4dPV4Q0=;
	b=SERrZCjKWlOwIRVbfVlEMRC8feZEUXmFrX7G53TCbsZqVbsJXhF5Tsk4zwlGySct
	M0X2T0iSNezGvnlRqqo91qJllJthK3QzRy6NPRjdXjfY2dwMQ8J3CE2eXllQ+DgDZS5
	mZomb58PTsHkpCK7/BeGWZH4IbhMS2p8V6Hvv7QI=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1779432750919223.90762740528305; Fri, 22 May 2026 12:22:30 +0530 (IST)
Received: from  [106.219.3.73] by mail.zoho.in
	with HTTP;Fri, 22 May 2026 12:22:30 +0530 (IST)
Date: Fri, 22 May 2026 12:22:30 +0530
From: Ashwin Gundarapu <linuxuser509@zohomail.in>
To: "anthonylnguyen" <anthony.l.nguyen@intel.com>,
	"anthony.l.nguyen@intel.com" <przemyslaw.kitszel@intel.com>,
	"andrewnetdev" <andrew+netdev@lunn.ch>,
	"davem" <davem@davemloft.net>, "edumazet" <edumazet@google.com>,
	"kuba" <kuba@kernel.org>, "pabeni" <pabeni@redhat.com>
Cc: "intel-wired-lan" <intel-wired-lan@lists.osuosl.org>,
	"netdev" <netdev@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19e4e74ff40.601fab765713.9212104302286035517@zohomail.in>
In-Reply-To: 
Subject: [PATCH net-next] net: e100: remove redundant static variable
 initializations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail


From: Ashwin Gundarapu <linuxuser509@zohomail.in>
Date: Fri, 22 May 2026 12:20:23 +0530
Subject: [PATCH] net: e100: remove redundant static variable initializations

Remove '= 0' from static variables eeprom_bad_csum_allow and use_io.
Static variables are zero-initialized by default.

Found by checkpatch.pl

Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in>
---
 drivers/net/ethernet/intel/e100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index bfacf877ca40..bdddd4315cbb 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -167,8 +167,8 @@ MODULE_FIRMWARE(FIRMWARE_D101S);
 MODULE_FIRMWARE(FIRMWARE_D102E);

 static int debug = 3;
-static int eeprom_bad_csum_allow = 0;
-static int use_io = 0;
+static int eeprom_bad_csum_allow;
+static int use_io;
 module_param(debug, int, 0);
 module_param(eeprom_bad_csum_allow, int, 0444);
 module_param(use_io, int, 0444);
--
2.43.0
