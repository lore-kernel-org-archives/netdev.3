Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B159E41A57D
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224025; cv=pass; b=Ra6XzGZeIev/Om+EKlVUkgj8A9elvznlTvncwI/hqDIp0Z1F6Fw4B1S/wiWQ6Wjreri69bP9YUVdENEuTBYrW09TvClD+ylrwvux6yno4M4JG18U9NzxzkYXrB26KOge1cTJj6etZPtElQuq6aKm58JgCROC7sesgCgUFHXGA3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224025; c=relaxed/simple;
	bh=OhTQVhu5obrSIvG8E4nEDt1ydTbCHzVuQ14nWwyVXx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ex9l9zcDRFIQYPzA7JLdwyt5HeeY50vQPinURh5sBHZG5jrno7fwfmtD62I1VsT7ZUM7lPm0qgelVVq/IL9pOj51vT2QEwJHodygTZUcIUyRd6WAu0+pr2REzbW0wA3NnGPLyZM707143D+/8s5ViLXenBUrGwwWmJYhoMppK/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=bmcAxpld; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=DJU46T2Q; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="bmcAxpld";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="DJU46T2Q"
ARC-Seal: i=1; a=rsa-sha256; t=1787223983; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jwMoPOPLCWptUUO9NZPeOschElmJX7KqY537xJD++tsKeTPrnPqGW1bCsI8lYrLmv4
    /T1iAZyi9mwmjtufJqOekutZun0rv6ITkUgMSyW6yW1/oKtcb4ZIorjpLImNUibXdDnY
    eJP4hBoIY4oAyyqgdt02yVZzbdY0PtjTUjKvq4sExFkvB+YFmXU4YVqY5t6xGdzKkwfZ
    jDsb+RVcoBagqYUqjR0Z5mDbuBRHpNz1jFvN+CA1EV0vBydvDJqkEIQKEv/45oECvhEC
    KBYeNZzFazd/9aXyH/URXIcmspULXU4j3cTCxjQf8TNoraqFzIgpJj7ApYOIDNms9Rya
    vw1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787223983;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=MTm33Tfxa8VfGbWidtLVzFe8VH8slu+/r6lm7/fuu34=;
    b=d8zkxDNV/S+7xpjyjoMta/iV/HMRx6BzzfyhiNxcBT3D2atHXCVgCORhILuZ8kq6Od
    t8PlG0Owo3aY2WQiH3rVkqlU5wymnzurLoQSPAgmiFIvveUrbAQkdP33K+AOOolI5VYi
    W0nYZ/ZyBtvKeFwhaGpE0eL8kSOGh/AX+SyBrcf/RANlasHaV7MH+0HA77ZltP4t6umY
    Snlxj3ZeKAE84prSUevZQSMc4tKtReYJhDLiniKgSMgtJ88uZJrPI6JnS4TB9R9xhrsL
    nUu+biEbB4zJ9g/KpD669jWCoVJTyZml+V52balaY/KghowdYqeI5DWTVkZcDwuXQ/TU
    uDSA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787223983;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=MTm33Tfxa8VfGbWidtLVzFe8VH8slu+/r6lm7/fuu34=;
    b=bmcAxpldXb4eodOP0+KgWPz/EmpRSVj6Wu+CFgf3b3bcbO27IjThSQo19mtBiDibaN
    opwL7R5WBJCOH3977i7giDX8eiSsyWUyeU9G4oq1tYAEsvOKUjtVa56Ue7OpwSLAlUD5
    oprGdMb45QvYCiid3USfsEYD7fRIKHwt4uMUsBo8B4LNO4WPcwbVyPStfjzl6rLzq+13
    zhjVKGiaUKT2eFGGmk3szZNifmiObAFcg+Utnz8VanS/yL/vM8us7l8lwJjd37q9GMpx
    /zfjRE4pRGj90rasyl8CAbhvYt2/KN7KT4ayuSaSl5oGRnZIcar4rpDMAvYsSrHghfUl
    Fr3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787223983;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=MTm33Tfxa8VfGbWidtLVzFe8VH8slu+/r6lm7/fuu34=;
    b=DJU46T2QJ0OO0gndCWttAX3VOnPS+EQQ9L69GqyNPwFbDEWDJdi8eWau2vi+yNiNIs
    TqJjhnhoSFV7WL9I7MBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b727KB6NPmb
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 20 Aug 2026 13:06:23 +0200 (CEST)
Message-ID: <9e3e44ac-8725-4372-af4b-e5092c8a3810@hartkopp.net>
Date: Thu, 20 Aug 2026 13:06:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: do not bond/team netdevices which use ml_priv
To: Alexandra Winter <wintera@linux.ibm.com>,
 Hangbin Liu <hangbin.liu@linux.dev>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
 Jiri Pirko <jiri@resnulli.us>, Jay Vosburgh <jv@jvosburgh.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jiale Yao <yaojiale02@163.com>, Aswin Karuvally <aswin@linux.ibm.com>
References: <20260815153938.187073-1-socketcan@hartkopp.net>
 <20260815090015.4a518a54@phoenix.local>
 <02333bd9-89c4-4952-8ae2-ff3c15dcd4df@hartkopp.net> <aoQwCj9AXNI1qfsu@fedora>
 <072004e8-d5a8-4f01-9dd5-da2d3aeaa447@hartkopp.net> <aoVzaHfKWG-_OJOY@fedora>
 <9cad8318-049c-4ba5-9e3e-fe1d843055f4@linux.ibm.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <9cad8318-049c-4ba5-9e3e-fe1d843055f4@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alexandra,

On 20.08.26 10:29, Alexandra Winter wrote:
> 
> 
> On 19.08.26 11:12, Hangbin Liu wrote:
>>> The fact that the issues have been found by syzbot for CAN devices might be
>>> through to the fact that the virtual CAN interface (vcan) can be created by
>>> netlink commands and can be easily used in test setups.
>>>
>>> So what would happen, if the same tests with bonding/teaming/tunneling would
>>> be done with real hardware drivers as the mentioned "direct ml_priv writers
>>> still in tree at this revision:
>>>
>>>    drivers/s390/net/qeth_core_main.c:qeth_alloc_netdev()
>>>        dev->ml_priv = card;
>>>    drivers/net/ethernet/chelsio/cxgb/cxgb2.c:init_one()
>>>        netdev->ml_priv = adapter;
>>>    drivers/net/wan/hdlc_fr.c:fr_add_pvc()
>>>        dev->ml_priv = pvc;
>>>
>>> plus drivers/net/ethernet/i825xx/82596.c, drivers/s390/net/ctcm_main.c,
>>> the libertas main.c/mesh.c paths and
>>> drivers/net/wireless/microchip/wilc1000/netdev.c."
>>>
>>> ??
>> I'm not worry about cxgb2 or 82596, which are too old. But s390 qeth is
>> still actively maintained (Cc the maintainers). Can we block them directly?
> 
> 
> Thank you very much for the Cc I would have missed this otherwise.
> While drivers/s390/net/qeth may be decades old, it is still the most used
> network driver for the s390 architecture.
> 
> !!
> qeth_l2 is an ethernet driver and bonding is heavily used by our customers.
> So: No, please do NOT block bonding over qeth.

Agreed.

> I see your discussion has moved on to other options, but I wanted to point that out.
> 
> 
> 
> qeth_l3 is a transport layer driver (arp offloaded), so I don't think bonding or teaming
> can work at all there.
> ctcm is not based on ethernet, so I don't think bonding or teaming can work there neither.
> Aswin and I will put it on our ToDo list to find out what happens, if somebody tries.
> Maybe we to add them to the blacklist you mention in a later reply?
>

Ack.

> 
>>
>>> If bonding/teaming/tunneling might accidentally overwrite dev->ml_priv we
>>> have to block all those devices. No matter if it is CAN or whatever ethernet
>>> device.
>> How would bonding modify dev->ml_priv?
> 
> 
> Could you give more information about this?
> I hope there is no issue for qeth_l2. There we use and rely on dev->ml_priv.
> 

I did some more investigation on all this.

There are 5 drivers that are using ml_priv:

- qeth
- ctcm
- cxgb2
- i596
- wilc1000

where qeth and i596 are using it to store a single pointer which can 
also be done by adding this pointer to their netdev_priv structure.

wilc1000 assigns ml_priv and never reads from it (development leftover).

Only cxgb2 and ctcm use it in a more complex way that would make it 
tricky to move its functionality into netdev_priv without having real 
hardware on the desk.

Either team and bonding do not fiddle with ml_priv on their own. But 
they make assumptions that best fit to ethernet devices where they don't 
care about nor copy any ml_priv pointers.

This caused a problem on CAN devices that were not created by the CAN 
driver infrastructure (creating proper ml_priv content). When TUN/TAP 
set the dev->type of an ethernet device to ARPHRD_CAN the CAN ml_priv is 
NULL (not initialized).

Long story short:

The ml_priv assignment in wilc100 can be removed.
For ethernet devices like the qeth there's no problem AFAICS.
But I would think about making use of netdev_priv() there:

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 41fe8a0..b21bccc 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -798,8 +798,20 @@ struct qeth_priv {
         unsigned int tx_wanted_queues;
         u32 brport_hw_features;
         u32 brport_features;
+       struct qeth_card *card;
  };

+static inline struct qeth_card *qeth_dev_get_card(struct net_device *dev)
+{
+       return ((struct qeth_priv *)netdev_priv(dev))->card;
+}
+
+static inline void qeth_dev_set_card(struct net_device *dev,
+                                     struct qeth_card *card)
+{
+       ((struct qeth_priv *)netdev_priv(dev))->card = card;
+}
+

diff --git a/drivers/s390/net/qeth_core_main.c 
b/drivers/s390/net/qeth_core_main.c
index 7376a45..b00fa77 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4562,7 +4562,7 @@ void qeth_tx_timeout(struct net_device *dev, 
unsigned int txqueue)
  {
         struct qeth_card *card;

-       card = dev->ml_priv;
+       card = qeth_dev_get_card(dev);
         QETH_CARD_TEXT(card, 4, "txtimeo");
         qeth_schedule_recovery(card);
  }

(..)

A similar easy adoption could be done for i596 too.

ctcm cxgb2 should stay on ml_priv usage but they should implement the 
tagging of ml_priv, e.g.

diff --git a/drivers/s390/net/ctcm_fsms.c b/drivers/s390/net/ctcm_fsms.c
index bf917f4..a1465f3 100644
--- a/drivers/s390/net/ctcm_fsms.c
+++ b/drivers/s390/net/ctcm_fsms.c
@@ -246,7 +246,7 @@ static void chx_txdone(fsm_instance *fi, int event, 
void *arg)
  {
         struct channel *ch = arg;
         struct net_device *dev = ch->netdev;
-       struct ctcm_priv *priv = dev->ml_priv;
+       struct ctcm_priv *priv = netdev_get_ml_priv(dev, ML_PRIV_CTCM);
         struct sk_buff *skb;
         int first = 1;
         int i;

(..)

@@ -1097,7 +1097,7 @@ static struct net_device 
*ctcm_init_netdevice(struct ctcm_priv *priv)
                         CTCM_FUNTAIL);
                 return NULL;
         }
-       dev->ml_priv = priv;
+       netdev_set_ml_priv(dev, priv, ML_PRIV_CTCM);
         priv->fsm = init_fsm("ctcmdev", dev_state_names, dev_event_names,


The final question (which is not really a ml_priv issue) is how to tell 
team/bonding which netdevices are not capable to be used by them. To 
cover e.g. your ctcm driver using ARPHRD_SLIP.

The current check (bond_dev->type != slave_dev->type) would allow to 
join two type-identical interfaces, which was at least not a good idea 
for CAN. For that reason we already check (slave_dev->type == 
ARPHRD_CAN) there. Other dev->types might follow.

Not sure if collecting a bunch of ARPHRD values is the right approach or 
whether team/bonding should check required features and settings (like 
IFF flags, e.g. IFF_ARP or specific address length)?

Best regards,
Oliver

