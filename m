Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452705;
	b=IGYLhTaxV2mnqFVEMpvFsuq0aVwwPR4ldAeLpzfV3ifMAcChawplQGJsdAsR2VJ2G+Ro
	 R0Ykisteqrg3D4sy4iz6TPzVY90xRBfUotXmv3pDbYAT+Fz5Mi7TqgEnvCxPP89hmQlcA
	 2Eur2fo+VyaQ87wdu+1m85poiIhaqtVSNA6WtMTs6ud8DFj7amEYdNSTamKV3mqdkvwSz
	 OuGnPSGNvTYHq/4vaRu+EHaPJAF4l393Gm2oiQqjafyxHHuB1e4FVnJtYOM6ntibMZnEa
	 EDCW94Rtmxu6KhntWY0NV86MHVm4iUh3hnEIwehTWR36L4eB4VlvINoOwI3YWZy4hIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452705;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=M7sScAJH0Ul4qGF1IQDE0Kb21mlcK+/HHOmL3xOQumY=;
	b=E184sCssyEazgSr44fRBIBDPmD5cwImiTqsTlAS15JKHKrABDmIGPYo0CfxUB0TI78kK
	 r2PH/8MibAMwfr4VcUWhOXuzfh7MNx1yVQxNwSPMhajX5CB3XfpcEHxLYjp0eqd+rCbfX
	 SIc4DsVat9+0ujYYdqQz0oM3cxgT9d3ys0oEMl9c+1IrtkBcX7YR4Ci5XU4n6NlsA4tvO
	 PbLw47vvJg3iK8v/wOsLUN5hKMb5Pe6ActT9eMcYqlOWhu6TWNjg+He7EOrptUqKKE+Dq
	 LcDM5Y7OKTdkEKGeGHWsrkpTqKl6Bl6QGn3CdIuOhOeFDOvJgL60QJOEs/8G+PCPtAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=XNl5cstd;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D308606A31C;
	Thu, 12 Nov 2026 03:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D308606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=XNl5cstd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=XNl5cstdPNUdtFQJCAAnf7WhvTCbxRa0kFA6BXgfygEiKpvCXYZ4S77WU31BgpTM7Giz+K7R6X1Wc
	 m3GFCrT5HEAEK6hXjcCMN4VVmbd+UTyHNRLN4QvdvQJRc6VShnXgQ4TKk8wlUrxtU4IGD9Bgiw/ge2
	 tv+kUc5FcArOtSgo=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86af52cdeb01-7cd72;
	Thu, 12 Nov 2026 11:05:02 +0800 (CST)
X-RM-TRANSID:2ee86af52cdeb01-7cd72
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16af52cdd13e-f04cd;
	Thu, 12 Nov 2026 11:05:02 +0800 (CST)
X-RM-TRANSID:2ee16af52cdd13e-f04cd
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: netdev-bot+sinfo@kernel.org
Cc: Jason@zx2c4.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: Re: [PATCH] wireguard: Mark concurrent accesses to reused indices
Date: Thu, 12 Nov 2026 11:05:01 +0800
Message-ID: <20261112030501.119509-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <179445106063.2168702.961983939936124723@kernel.org>
References: <179445106063.2168702.961983939936124723@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The access pair addressed by this patch was observed at runtime by
syzbot/KCSAN. The report is available here:
https://syzbot.org/bug?extid=54fe9e7dbf4babbaeea3

It records a 4-byte write in wg_index_hashtable_insert()
(drivers/net/wireguard/peerlookup.c:132) racing with a 4-byte read in
wg_index_hashtable_lookup() (drivers/net/wireguard/peerlookup.c:211).

I have not reproduced the race locally or verified at runtime that this
patch eliminates the report. My local validation was limited to W=1
builds of the affected object on x86-64 and i386, including an x86-64
KCSAN_STRICT build. I have not demonstrated a functional failure such as
a crash or incorrect packet processing beyond the reported data race.

If another revision is needed for other reasons, I will include this
report and the validation limitations in the commit message.

Thanks,
Zhu Jun


