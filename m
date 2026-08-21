Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAE023AE87
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 11:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787311058; cv=pass; b=X8jQeALKiuTe2zxgdfBt3ad/ZGRh4iv+CtEJxa+A46VVIaqDI4+SSyeEFbirJ4LP3uX9C07VWo/XuFep1t6bUqrNuzaJrsl4a/4P9zMwOsE/3WjNwo3VZ4h/bFachY5eCzKV00QFK622Q6U7pYHhAYcFotCaYGQoOgOsbLQE1Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787311058; c=relaxed/simple;
	bh=B+F8nzS1lOh5U/cLnjpNxowB6BHt7QMeTmE5kbrimrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEr9dcJ2/UrGCUZ7iIc05fZ+qCqLzsKP4K5BN4W4Rcip9FFn/c1rv8yjOUodMBX7kB+zoy+OwVxPQiDY1RSS+wo52XNXJurLuVdbrsUvCUYajo7uvnqsxMZAVWy0fCmxpWqVvF9kM8D59yk5OErH2QoYaypIvqIsmphlFgRKk24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=pdXVVLnS; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=vU9vQ6U5; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="pdXVVLnS";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="vU9vQ6U5"
ARC-Seal: i=1; a=rsa-sha256; t=1787311031; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ar8oPJ/XTYf3hGDLPzBjfwBzpZFXc+IByLvcYTDe7nXHKz+ob2I+Zu8CgpMxkm8rOr
    I9FkBgJoE4/oasQzHJMK4nj56NIqxdcQ1WO4cX5qIaox+3y89M0zNwn8hw6V197mzhuI
    QscRHT0f3jButsNd4iGG0K14+rgQFOVWkIBRaayvpiKwB5Mta17Pen7cR2MXV5sQ/nKx
    K3IKBbO0UZJR0YrpMalK0bXkMD8wMp2NngFoBD9Wz/6+clS+T3clbayRWr1Zt3dLIk0Y
    C42C4/Z0pRVN80APQcBiFzs6H1/tY3CphFAv4zH5S9jESqkjEyHdHNP8O/3UWYbx8JUR
    UqEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787311031;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BECdEvoD3eUa9iEoIQ8djnw+OBIX5O+C8OPJ7Bym9Hs=;
    b=iRXxJhxfLEYAYv2ho0Bi+QfxrITz/CozblshCOh1Q1QkD8egCGn0BBT2MrlR0zl2ni
    rTtrDbDKeBlvbrBaUqePwl/H30rs0gYwCwTn8hUcqtqmvJcUsijjAwhbTVpQ4yDeSy2n
    3AYkrSyqnjti+FMuAVVqjUcJHM0i3Y1AfQAgyv1D7LZiOJDMBrUXm4M41UuX5zT+ctRo
    HzptGVvodPtNkfHRM0D/+BcJIMcmE6ctFpjg4CLzKhDtrFRMLj9ptgdinW/ePpsNpSmv
    EWFUQjoQ36LBtNkuw4Ysb9SLFT/WjAJdCWydHxLv/WBCqpa2sjmd4GGwCHsXI/sypT8F
    H4kg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787311031;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BECdEvoD3eUa9iEoIQ8djnw+OBIX5O+C8OPJ7Bym9Hs=;
    b=pdXVVLnSOJYqnt0CwJJq5ngm+mcpOKlZq3Wd02YfjpsTxESeuA2pD/D4q7nww5YCp7
    9NT4K661pNLSJ2Ev/InM1elCpXOr2W6WWqCf9fBw04+McIV85wmIxieZV8TyaIZYZ7Kj
    igq/xvfz66A8xRv/tD3Lm0oJNaBnAZqMNGnixzi2tZaQcDTNana1X9oD8YIYPY4YiU82
    5Ir7FgVybxIbZ0Pva43u4U6/+6JhMWsiXHGxdZCUVqTWFTYlIjMqqv2VWejDtdLwX4Jv
    VrMoKt4bLjBIVcFbjMwj6wUb/bnfywszoTQuXR5GFgh6q5weHFBOyojePjU5b3vWah4S
    5H8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787311031;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BECdEvoD3eUa9iEoIQ8djnw+OBIX5O+C8OPJ7Bym9Hs=;
    b=vU9vQ6U5pISAmAVy+ksEr4fiFLxYx87cl2FRQdoD7fai7b5OVUfRQdpETVax/MkiVM
    LEt2C8S5TRuuOYlOOyCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b727LBHAU9G
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Aug 2026 13:17:10 +0200 (CEST)
Message-ID: <6001bd73-ef68-4820-8371-a22775fb820a@hartkopp.net>
Date: Fri, 21 Aug 2026 13:17:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: do not bond/team netdevices which use ml_priv
To: Hangbin Liu <hangbin.liu@linux.dev>, Jiale Yao <yaojiale02@163.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>,
 Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
 Jiri Pirko <jiri@resnulli.us>, Jay Vosburgh <jv@jvosburgh.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Aswin Karuvally <aswin@linux.ibm.com>
References: <20260815153938.187073-1-socketcan@hartkopp.net>
 <20260815090015.4a518a54@phoenix.local>
 <02333bd9-89c4-4952-8ae2-ff3c15dcd4df@hartkopp.net> <aoQwCj9AXNI1qfsu@fedora>
 <072004e8-d5a8-4f01-9dd5-da2d3aeaa447@hartkopp.net> <aoVzaHfKWG-_OJOY@fedora>
 <9cad8318-049c-4ba5-9e3e-fe1d843055f4@linux.ibm.com>
 <9e3e44ac-8725-4372-af4b-e5092c8a3810@hartkopp.net> <aoet6aHyJI5lGNOX@fedora>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <aoet6aHyJI5lGNOX@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.08.26 03:46, Hangbin Liu wrote:

>> This caused a problem on CAN devices that were not created by the CAN driver
>> infrastructure (creating proper ml_priv content). When TUN/TAP set the
>> dev->type of an ethernet device to ARPHRD_CAN the CAN ml_priv is NULL (not
>> initialized).
> 
> I don't know why a user change the tun/tap dev->type to CAN. Can they work
> together? If it's a miss config, I think we can just leave it since we already
> block CAN slave.

Correct. We currently block ARPHRD_CAN in bond_main.c

>> Not sure if collecting a bunch of ARPHRD values is the right approach or
>> whether team/bonding should check required features and settings (like IFF
>> flags, e.g. IFF_ARP or specific address length)?
> 
> Bond supports none arp devices. It also supports infiniband devices. So we
> can't check it with IFF_ARP or address length.
> 
>  From my perspective, we can keep the existing check as it only causes issues
> with CAN devices. We can work out a better solution if more incompatible
> devices are found under bond/team.

I've checked some whitelisting ideas for bond and team which did not 
really work and turned out to be risky.

In the end the V2 patch from Jiale Yao testing for ARPHRD_CAN and 
ARPHRD_IEEE802154 / ARPHRD_IEEE802154_MONITOR (suggested by 
Gemini/Jakub) seems to be the best idea!

https://lore.kernel.org/netdev/20260728151240.89434-1-yaojiale02@163.com/

ARPHRD_IEEE802154 / ARPHRD_IEEE802154_MONITOR do similar things like the 
CAN dev->ml_priv approach but with dev->ieee802154_ptr :-/

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index feaa75fbf8fc..d8c46105fc8b 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1224,6 +1224,17 @@ static int team_port_add(struct team *team, 
struct net_device *port_dev,
  		return -EINVAL;
  	}

+		if (port_dev->type == ARPHRD_CAN ||
+		    port_dev->type == ARPHRD_IEEE802154 ||
+		    port_dev->type == ARPHRD_IEEE802154_MONITOR) {
+			NL_SET_ERR_MSG(extack,
+				       "CAN and IEEE 802.15.4 devices can't be added as a team port");
+			netdev_err(dev, "Device %s is CAN or IEEE 802.15.4. These device 
types can't be added as a team port\n",
+				   portname);
+			return -EINVAL;
+		}
+	}
+

And for the same reason the same checks for ARPHRD_IEEE802154 / 
ARPHRD_IEEE802154_MONITOR need to be added in bond_main.c where 
currently only ARPHRD_CAN is blocked.

And I would suggest to have two separate patches for team/bond and not 
create a common function for now. Also to provide proper Fixes tags.

@Jiale Yao: Would you like to pick up the bond patch too, so that your 
team V2 patch together with the new bond patch will solve this entire issue?

Finally this will fix these three users of "ml_priv"-style non-ethernet 
device types.

The general discussion about the ml_priv usage in

- qeth
- ctcm
- cxgb2
- i596
- wilc1000

gets relaxed after drilling down the shown critical cases. The use of 
ml_priv is simply legacy code and we can make some cleanups/enhancements 
there without pressure.

Best regards,
Oliver

