Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216149;
	b=Z/lgXjZrXOnyoPSrxSCMQivbrpO0/8IpB+74JpgX5Uq3S5VJmJHRfaiW2MLLMww9cJan
	 9wlr2Cfhed9axgJV0bmGoPlq9uAj8MuIVTakw3BjfO89iU5M4551gNFSCskYn9qQtO5GQ
	 npg5fGRFqM4c0SBsVd/PJ9YzKrD4i9EQyBtThWSUxO5gHT+WZi43lZEF1sDT2E+1aqQB0
	 pE1D0LWhP3GhZEQciDIn8otZbSFkuy5AnSwa5ZDNmz/2Db8MifCnxiiE0arB5ejdAGwMQ
	 qWqDY4tRk/48jESvABMz2GvsGKCrsHd1xDqPlY3doTP142Uw+jQFjHcyB3ke0F911fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216149;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:
	 X-QQ-RECHKSPAM;
	bh=cQxbZtVVgvosk1eSe8/APCl76Blh719OYvdh/WfknF0=;
	b=U0XX1ZmFuzztfx3nnH9d7RDRQUuGlyM4WNxtWaH6QwmDV8eLlA8wFRcbiC4VWyXbzCdN
	 b5nwoPNLQsIbbJmywh9Uj08yU7r3JLhB4pmqqu534KHJ0rJRJJV3QizVUTctEIGAMTDj1
	 0C5oNC9C4w9mUzOUHgrHjgTACfQfdyivLxk7jFUlQmsD4Vq5OzUKQMv1elyHV1bJ7yDMS
	 ovye+3owNof643zJOux3tRtySW8psGvHYb06nxQkjTEM/ws1hJ1u4gBf4jpt5u5VY3jEL
	 U9rGbfbe98nwnWaoBGI2hdusuT5NYN1u1l0sSscVPZRXTxhafxA1B1CGRBjRXSQvedw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mucse.com;
	spf=pass smtp.mailfrom=mucse.com;
	arc=none smtp.remote-ip=54.254.200.128
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E370606D812;
	Mon,  9 Nov 2026 09:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E370606D812
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz11t1794216093t4530cbab
X-QQ-Originating-IP: XZ71wldAWEXdtucz6yDOn3lHr8NFxKLRnsb7gWSo4y0=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 09 Nov 2026 17:21:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13161699349333163398
EX-QQ-RecipientCnt: 10
Date: Mon, 9 Nov 2026 17:21:31 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	yaojun@mucse.com
Subject: Re: [PATCH net-next 3/5] net: rnpgbe: Support copper link
 configuration
Message-ID: <8278B19A4BE53468+20261109092131.GB286191@nic-Precision-5820-Tower>
References: <FB722C2F25FE9005+20261106112420.43050-1-dong100@mucse.com>
 <D2E577671FEE0E12+20261106112533.44065-1-dong100@mucse.com>
 <a60f0f38-85c7-4453-8a9d-310db05f4615@lunn.ch>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a60f0f38-85c7-4453-8a9d-310db05f4615@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MSDmV4hBxmsCqd5VDVFII19zYiobZ2Uk2M7M1tbI8aRG61aAusDaUe2m
	dQuM7baZmJQ03x4VaGhYunczyYxZXKsLc2jFeXHCnGHZCLPzr9UslDqtNHBbZj8UoTOEl6S
	W/7ilVB5tHsr8YqWJUlQYgdVrQ4GwKQw7ue0NYFmi+h0D9V8AyYa/e6hO6Y526h1lEde1ob
	ryzQRMI2ufHX3agqMmKNAtKuhvZerkf/NUQyjxwZKOTK6ltGb/WdWdPete6BE3lyzJ5/G9h
	gJmcPRuqVPE6zkh73LU3C8xAhGVvBTqjRwHshdCY7/FtAn9WgbAKmwd38f3WH5X3kH1LRBE
	a8qPXXIgAft6gabccF37h63sDKJm5Em0aqyhIqqYdjnSqicePNbwK6WeIXGbsVErCJ6ze6W
	HPghhLWXdyQO9G1ANcL5oYMr72EFakZC8+HcI3qw2cuO/Y37wY2h03Cn1jEtRIHNqkRayTL
	kKgF2tbqfwQPWiwDtk6/cqD5e2dr0oofDhNwYYwEMePPB18WC9g3oaoEH7J+eKvpLHleuoJ
	wt5Q63caq2raE8MBPA+nvLULNvf62DTRVflEKrXuDdCy2PrOSQRfPWvnlrWZUWOIpc2budD
	PxQLVMc8FELPAKUhKMXDRrxhn7g9Metf9sJMeQmPedWsHDYen/c6L8dLE+qFb/7nJ9fwLn2
	VcNtFy7lFA6gZCDmNHsa9b2JLNy2VUgUk6hwKSt/egams08tCEAD+/QciCNC8PkLjyE86WB
	Dau0f16fyWqMSCZk57Z8qGk7c4H8ek/eix1VSJ1biNI/eMktlYu0S2I8Y5ow9shwGw/qXcK
	zTekGUweKVbPcks6P98+zJNN+rloslQ2H35KvsYHEuMnU/4HZyZQWA5KwqQzfwyFNCwJ2BD
	G1efpODgViO7Ewi+o1AvU3PHINyWZY4sNFyWBX7Sccfg5BLTOHIfJgKZHbO9Qn2HZqUdlp7
	sudBNTMwbuHY7I/Qky6PIIXFeAgjliwpWjoB5mRgMacRf9wRaF+dBSQyHB99c/u21Z4JI5m
	FqVEahNps5cHOH3k3jwvDSNGPfik7p9irOTaWOyeV7ei0J5ZLe
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

On Sat, Nov 07, 2026 at 07:04:20PM +0100, Andrew Lunn wrote:
> > @@ -236,7 +236,7 @@ int mucse_mbx_set_link(struct mucse_hw *hw, u32 advertising, bool autoneg,
> >  
> >  	len = le16_to_cpu(req.r.datalen);
> >  	mutex_lock(&hw->mbx.lock);
> > -	err = mucse_write_and_wait_ack_mbx(hw, req.dwords, len);
> > +	err = mucse_write_mbx_coalesce_event(hw, req.dwords, len);
> >  	mutex_unlock(&hw->mbx.lock);
> 
> This seems out of place.
This is needed because the new ethtool setter can configure a running
interface while firmware link-event reporting is enabled. Commands and
events share the mailbox buffer, so a pending event could be overwritten
by a command.
The coalescing helper acknowledges the pending event under the hardware
mailbox lock without updating the link-state snapshot, allowing firmware
to report the current state again.
Would you prefer this change to be split into a separate preparatory
patch, or would explaining the dependency in the commit message be
sufficient?
> 
>      Andrew
> 
Thanks for your feedback.
