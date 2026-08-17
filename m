Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A24235677E;
	Mon, 17 Aug 2026 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786989026; cv=none; b=asF4FtK+qaRTeW8r4H3JmNmuLUOnpTfqPb0DtO4ZhcHa5OFxUbuYj+k6tsYc1BYsfN0s+Ku+sGc9OPTzusHzWPkjj7PCukjAiAlqujn65tP9w76zTJqxMvGsEQNzKKJN2OBanfo+MDYZ9D4Y8EPx6dILeVwJM82d6WSp2BxhH8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786989026; c=relaxed/simple;
	bh=IBOpmn9assWtoJWAXunZJLYYuMuObQFAp45IzmLnsek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6xwqvRr0xk/BW1ANcll7ECpz7HFWQdblfnM+t6KTkjTVSm2Ve5x9mCd9OwSqbNKAVktYHoXvy6tVo+ihpudbr13NmoaCqyR6YGcVs+Gb6K5s/acXTit+0qf4UhehME+sUIWcdEfNR1mUwuZG7KYqwglSpbAoh3DaHkeZXsriHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrV5Yvkg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrV5Yvkg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E527C1F000E9;
	Mon, 17 Aug 2026 17:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786989025;
	bh=IBOpmn9assWtoJWAXunZJLYYuMuObQFAp45IzmLnsek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mrV5Yvkgu3pkRMK+iOoRwiEYNurpxPgpfh+3QjAGdyyohhM42pzzTJaRuSOAc+efD
	 V7nlYB6Eq9QssydgHGbPGAFk7apUMbFKPpcdfBYNaBqTNMLig6uJCBkhAdoUA3HPu3
	 ZFGTr72ge1eK7sdf5TXQug34YEUKKQEOf/33KAMxgNdujVGkE3PcT6eJOfc1FxIU1r
	 tb86/7fMsV6CicwsyV+TIJhPF3U0mQHusamisWOWAjQKZ0TbaaT/PV/4rOfkOWT8x8
	 APQdgsXvEgXNKzHFpJxtsmAsCZekWf1z7ws0lZqZhVRQ9DdgzQvCXmuc1NrP1se2GW
	 f7yOWl8kWBr+g==
Date: Mon, 17 Aug 2026 10:50:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cedric Jehasse via B4 Relay
 <devnull+cedric.jehasse.luminex.be@kernel.org>
Cc: cedric.jehasse@luminex.be, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Cedric Jehasse
 <cedric.jehasse@gmail.com>
Subject: Re: [PATCH net-next v8 2/3] net: dsa: mv88e6xxx: use the hw tx
 queues
Message-ID: <20260817105024.65be6d55@kernel.org>
In-Reply-To: <20260811-net-next-mv88e6xxx-cbs-v8-2-10d0baab2905@luminex.be>
References: <20260811-net-next-mv88e6xxx-cbs-v8-0-10d0baab2905@luminex.be>
	<20260811-net-next-mv88e6xxx-cbs-v8-2-10d0baab2905@luminex.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 13:45:48 +0200 Cedric Jehasse via B4 Relay wrote:
> When transmitting fill in the PRI field in the dsa tag to select the
> egress queue is sent to.
> From the datasheets i've looked at these switches have 4 or 8 transmit
> queues per port.
> Note: skbs with skb->offload_fwd_mark set use the DSA_CMD_FORWARD
> tag. These are processed as normal ingress frames, meaning the queue
> they end up in can still be altered by other switch config. eg. priority
> overrides, tcam policies.
> This isn't done for vlan tagged frames because this would overwrite the
> PCP value in the vlan tag (The PRI field in the dsa
> tag is used as the PCP value in the vlan tag).

Pretending that a DSA device has multiple Tx queues _from the stack_
makes no sense. You should be offloading PRIO as the root qdisc,
like mlxsw does. Then the rate limiters should be attached as children
of PRIO.
