Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B028332ED0;
	Sat, 30 May 2026 02:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780108573; cv=none; b=IgaBBw8WxLJaFGPas5nswUK8cbPYYI/b1IIExkc2cik7f+Fo5HM8RgHfFpRQKeor1xtpw/N52+X+hxmxkfSBFgC8bVwtqMMRnnuL1yXPCfqjvv2bRqSK1kL3m7mvAq7oCBy+5B/ME8oSPsWjCrTyREhRkUE3AhpIsPBkwgjD2/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780108573; c=relaxed/simple;
	bh=jzGeTmXryRjF0m/Cag3rWyuNGqgoHYTI2z1rexwVZ8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dhEedX3gTr28Pgwt5eqwYb7vFOKi8MLtSKqJBnVYtia/T9xIwlISlaFdKDnb8rqdJnzRwtaLBf8NPCCNZ2mQ2kQRIP+FNPutmS9K8eBaKsdCv1JWDvbv+E+TCOoyJMv7mtKEPiH1zZJb4gW0h8V+MsASZ+RoTNCVvlW3z/1QiAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=B0RajA/F; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="B0RajA/F"
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4065854d3;
	Sat, 30 May 2026 10:30:52 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: sln@onemain.com
Cc: aleksandr.loktionov@intel.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jesse.brandeburg@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: Re: [Intel-wired-lan] [PATCH net] i40e: fix netdev leak in i40e_vsi_setup() error paths
Date: Sat, 30 May 2026 10:30:52 +0800
Message-Id: <20260530023052.3103391-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <eb74ae1c-3027-42f5-ad5b-a6f2c2cd6a98@onemain.com>
References: <eb74ae1c-3027-42f5-ad5b-a6f2c2cd6a98@onemain.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e76b8544803a2kunm626b9a03e4269
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTh5KVhkdGU1OSxgZHxhPSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=B0RajA/Fl21y/fjBemzDmqxVeaQjCDMK/sM0r0gtGjmI6+FOOmpaV6uasxRqNsTxw3K0OeWHHn037zojWMQ9A88QoidRQzMTIkdmyYeSW3a57lX7UjydWWggJpgkBapojShpXasFslUpZOQ61o6mBLGddyRnFSxaMtJZ5SVHrV0=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=6EtOHmDddUVoeNMRlEOQToO3DJiZi1UJI7Jp56tA3Us=;
	h=date:mime-version:subject:message-id:from;

On Fri, May 29, 2026 at 1:57 AM, Shannon Nelson wrote:
> 
> >>   err_netdev:
> >> +	if (vsi->netdev) {
> >> +		free_netdev(vsi->netdev);
> >> +		vsi->netdev = NULL;
> >> +	}
> >>   	i40e_aq_delete_element(&pf->hw, vsi->seid, NULL);
> 
> Would it make sense to put these 4 lines into i40e_vsi_clear()? Then you 
> can also clean up i40e_vsi_release() and i40e_vsi_reinit_setup() in a 
> similar way.
> 
> sln

Hi sln,

Thanks for the suggestion. I will adjust this part in the upcoming v2.

Best regards,
Dawei
