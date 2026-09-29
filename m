Received: from out28-76.mail.aliyun.com (out28-76.mail.aliyun.com [115.124.28.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1CD2248B3
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 02:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790649959; cv=none; b=j3nLIVrkCsjk1oG3kvOeRw/ytFYFjjOr5b9no7AhtutRvq3ApKsG292HV2FipbrfH9s/NVIFf8btGAQltq2klBJ0ttR4GxweRtT2JjfSVV1XCJMWDUawjcbrFFAKM/JC54xOJQAffiTrtnC6Qp7kAhVf5bWAOnJfEWaxWJbf+G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790649959; c=relaxed/simple;
	bh=tO2BzWd5aG1anm9s+GVZm+N/7ES7gVAsYxbLIjUqA64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SyLgEuCibe01ceynxPJGW4E5kmFhbvfvIOU9otv/at/kY44HBPGgGxmikCrowlDYc2e2z6dtSMcn5C3ZN3iuCO7Iav6mTBOx3itEXANuzxrogQkx+cgMsp3BCqBGmn7xzOyQ4L6ZWLzvyZ7et8VzwInVo5piQtJbtufwbWaQsrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=jka0IjDE; arc=none smtp.client-ip=115.124.28.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="jka0IjDE"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1790649953; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=PHz1wET8Yx9ZhOn5PPI60tC1Q26JBd61SFPz2L7OSk0=;
	b=jka0IjDEcvoKUPfRPrZAX6aFatmzvfquAnfFUTVIQTKTuT9Rz418AjRjeNc439URBxrbPJuIHA3pScRHi/pidTMEBJjMqtfs0/RbgzciOQrE96DR24p3+lfGJHLbnbiEdmgY9gxSm1nh5MP0pLy3lP6nQ/lh1aAnZgsKCymO9H0=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.5038428|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00653021-0.000222695-0.993247;FP=12531533982799076606|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068005250;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.jQij6Da_1790649953;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jQij6Da_1790649953 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 29 Sep 2026 10:45:53 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: netdev@vger.kernel.org
Cc: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	chandrashekar.devegowda@intel.com
Subject: Re: [PATCH v2] net: wwan: t7xx: validate the HS2 message data length
Date: Tue, 29 Sep 2026 10:45:52 +0800
Message-ID: <20260929024552.249951-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179064985627.31693.17462376426668707461@kernel.org>
References: <179064985627.31693.17462376426668707461@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found by manual code inspection of how the t7xx driver validates
modem-supplied lengths: commit 0e7c074cfcd9 ("net: wwan: t7xx:
validate port_count against message length") added this kind of check
for the port enumeration path, but the CTL_ID_HS2_MSG handshake path
was missed.  Reachability and impact were then confirmed in a QEMU
guest with a fault injector, as described in the patch notes.
