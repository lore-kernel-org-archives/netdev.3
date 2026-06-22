Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB0B131E49;
	Mon, 22 Jun 2026 02:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782094301; cv=none; b=uRRwlUOkTkSy//VM9HZCcvBjtAY8OU/cD2+KOqJedjyayRZOUGnT/DdLl1nbHtED6BO08k1yAujO2ZNNDDSx96VybSWw8uVrBMkFoV/osYjotn/qlBlRoJJ5LdJyHYAIJw3aEMigbLW6GtmWaKmCJikCVpTDFJISn8m/VX9lOUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782094301; c=relaxed/simple;
	bh=+QNxGM3QWbBQl6PjOd7w0/p/8/g3JGIMvCdCsHqskjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/Nxfo3ZQwE9ztJCXJnufA+jTwFbx6LW9Ol3NQ8tWRu+N0btChhEqDrWzal6TGD6kH/JaXhRjtTyKahNskA9wxIMwuv29E92W4wsHcbTSGmxMMgsRDio4XYmXg82BFWMpQcJo1QD1fPO0Zo6UQG/6aKdCCakvfTL35mj8c0UTm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz4t1782094232ted16d78d
X-QQ-Originating-IP: a/MkLWp968cdZjx4xIT3fH/aUoG6w7Ab84uhqpBDf0w=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Jun 2026 10:10:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5481803057292495015
EX-QQ-RecipientCnt: 10
Date: Mon, 22 Jun 2026 10:10:29 +0800
From: Yibo Dong <dong100@mucse.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yaojun@mucse.com
Subject: Re: [PATCH net] net: rnpgbe: fix mailbox endianness handling
Message-ID: <06E034CB9B248796+20260622021029.GA342552@nic-Precision-5820-Tower>
References: <20260617083531.251119-1-dong100@mucse.com>
 <bf5366c5-88ae-418c-9c5d-b2249a7f43fc@lunn.ch>
 <0C93ADB24CB93157+20260617114614.GA273003@nic-Precision-5820-Tower>
 <26517b8f-33b7-4de7-8fe8-c7dca5fa7a4b@lunn.ch>
 <5249B5A1F6CD9ACB+20260617140530.GA278329@nic-Precision-5820-Tower>
 <20260617134505.57fea1be@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260617134505.57fea1be@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: N5WGgj4s5Wl78Zbov03xVs0FZ+xyq27GFek155tvHPoIyor3hC5xoqLt
	v/A2D369PtmgDS9dxHtYF727KLbpElE1wtMM2P5XkuIh3/KGJCptC9HaxBO5Jx9XIMQmG8M
	aR2O63jHAIudkcSmqI+Bku/Mpr70wWYCE4DnYVZefaAgZ6VuEMlvOWT//ffZT1JORxj3ELJ
	XyU4RixBdwfPMVf+rQjA607lhnZr3qbCakcSHSRVJuQ1RjMxt09dxrSLkm1HyZBdiNM2L3c
	wDQ4vBimsgma7M6OJZsTi/t9+DUdAT8048o1mgaT2xCG613c2sS90M0wL7xANDs2e2OTJeG
	/oOMOCykqxn9bo+0gSHTr/FYyH3oQbAO7pQrOkJ/cJl9G2cfGZcyBdRfw7m7Hc3AZWHAUqt
	sBkYW5oirGUzHd12F5vi7mIGJwNnA46m8+234XAIM7+PfisqbnnAIDzMqwmuV/7WKS2BxYI
	10XhnT9DCDLP9BF//SuAgcefqopf4pRWjcA9MN0EtmjG6RckFPEGSqG5ziA5qmKfxu9A3iN
	EIhgdu8ZP8v3JFfR8JVJieRXp4GKdHpuipc2xI+gsmmV8dtgJ/8zcqc9UlQq8bH+p1oVVr0
	XL/fYPq9xEbrjkSvpPJTQz6G/AKW0Vz+pA0m7lRxDnquE2PAtTZb12aoXf9LDgLPv1KmMlv
	28Dh0rfsRwcADiGB/FjjJdxm/OdOU1MmZrj3RTLPGRyJCNZcebmItLBpl2GhUsmXD1AsVQm
	qQnaAryitLCrwXbM2Ojc1VP1EVG7ZJEV/VQGScSZcMfJWFkz//S6K87urqn7D5YOQbDQXQh
	u6N8ZbiwGi9PnEa5TULgzWs7ajynviN8Em9eiW2Ey4I0j9Yn5rxGSo+f7F/NSU4+92LI04t
	kAAzwWZ6BGXlbODBmmqEOGsA5ccrDKiXLTRooVdNFnVF9E5R6t8k5/shAY/d8Nkmqaew+Hn
	O2lZIV8WAu1sf/hM8mlowqEjSZKuWgdWG+1ker5BjVEdLe/OzB7G1rJRjksbFOHP0dTNYBs
	uc23Guxmx+BtPGFDDJaHGGbIj5TI0a2hj0ZH/Yc6k0638B4vqPOvxOhyPb6zXml+93zlj+Q
	NyZnSMNLC8e
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

On Wed, Jun 17, 2026 at 01:45:05PM -0700, Jakub Kicinski wrote:
> On Wed, 17 Jun 2026 22:05:30 +0800 Yibo Dong wrote:
> > On Wed, Jun 17, 2026 at 02:09:00PM +0200, Andrew Lunn wrote:
> > > > My understanding is as follows:
> > > > The firmware structures are defined with__le16 / __le32 for wire format,
> > > > but the original code cast these struct pointers to u32 * before passing
> > > > them to the mailbox read/write routines:
> > > > - Send path: (u32 *)&req -> msg buffer -> writel()
> > > > - Receive path: readl() -> msg buffer -> (u32 *)&reply
> > > > Sparse only sees pure u32 = u32 assignments here, so no type mismatch is
> > > > reported.  
> > > 
> > > Can the code be changed so that it does not need the cast? Casts are
> > > bad, as you have just shown. This is something i try to push back on,
> > > it makes you think about types and avoid issues like this.
> > > 
> > > 	Andrew
> > >   
> > Thinking... Yes. A few possibilities:
> > 
> > 1. Make all fields __le32, then extract via shifts:
> >    struct mbx_fw_cmd_req {
> >        __le32 word0;  // [15:0]=flags  [31:16]=opcode
> >        __le32 word1;  // [15:0]=datalen [31:16]=ret_value
> >        ...
> >    };
> >    But that's painful — le32_to_cpu(req.word0) >> 16 vs req.opcode.
> > 
> > 2. Use a union to keep named fields while also exposing __le32[] access:
> >    union mbx_fw_cmd_req_u {
> >        struct mbx_fw_cmd_req req;
> >        __le32 dwords[sizeof(struct mbx_fw_cmd_req) / sizeof(__le32)];
> >    };
> >    union mbx_fw_cmd_reply_u {
> >        struct mbx_fw_cmd_reply reply;
> >        __le32 dwords[sizeof(struct mbx_fw_cmd_reply) / sizeof(__le32)];
> >    };
> > 
> >    The transport interface becomes:
> >    int mucse_write_mbx_pf(struct mucse_hw *hw, const __le32 *msg, u16 size);
> >    int mucse_read_mbx_pf(struct mucse_hw *hw, __le32 *msg, u16 size);
> > 
> >    Callers would use:
> >    union mbx_fw_cmd_req_u cmd = {};
> >    cmd.req.opcode = cpu_to_le16(...);
> >    cmd.req.flags  = cpu_to_le16(...);
> >    mucse_write_mbx_pf(hw, cmd.dwords, sizeof(cmd.req));
> > 
> >    If the transport layer forgets le32_to_cpu(), sparse would catch it
> >    because msg is __le32 * and mbx_data_rd32() returns u32.
> > 
> >    The downside is an extra union wrapper and an extra level in field
> >    access (cmd.req.opcode vs req.opcode) — a minor inconvenience.
> > 
> > Do you have a preference between these, or another approach?
> > 
> > Thanks for the feedback.
> 
> 3. Maybe use memcpy_toio() to transfer the data without any byteswaps?
> 
That's an elegant approach and would work perfectly if the mailbox was
backed by shared RAM. However, the rnpgbe mailbox is implemented with
32-bit registers, not byte-addressable memory.
Unfortunately, memcpy_toio() cannot guarantee 32-bit access width. On
some architectures it decomposes into the widest aligned access
available — e.g., alpha uses __raw_writeq() for 8-byte aligned blocks,
which would corrupt data on a 32-bit register.
For register-based mailboxes, readl()/writel() remain the correct choice
because they guarantee 32-bit access width. The byte-order conversion
then needs to happen at the CPU side via cpu_to_le32()/le32_to_cpu(),
which is what the current fix does.

Should I change to '2 (the union version)' for next version?

Sorry for delay replay.

Thanks for your feedback.
