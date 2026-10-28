Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214303;
	b=o9giSUz4rasUAKtyTX29lCCnphAn8dt1sftxtxkZVirL2UjjF3gxjHjVme4bzaw2bquG
	 7eywRe9LRnNetjHViPzyABZCcfCFqcaH2BNIbZSrftTEUL3f5fpLn3+4+SH0mbtvZ6B9T
	 ub8KQZbYSsoVQ5sdcrh/gNHKnJOefp5FB++yoATGAOz1LmDnshYKrVUuOVj2Tz0Sf+9Rs
	 b65ifvEphfvFBAnhfe8sTLqEmB58ivT49L/7pdtQ1FOw1A6fL56CkBkh25B6nb2KUpi0Q
	 WCcm+DbcfH5mmwGpiMLvQCy8KUMv1UiuIXtMfHzAS1pLTF79hrkUsEFZ3F1YCtWVgwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HBeP0TSiYus+H+GGePP31NmAMp8IAFuLA0XNaEeXXiw=;
	b=FVg0YkJX6YY+CYvMZI37zVrY9DUNdWt/26V1to/RIGSXcRqZ8yvqjeK+s1sj45iordj/
	 ygNcdT0oI0O3gvESYN1wV6TyB+lDFoMQsvd7fgk7LEhH+ph8n+xS+D4CZXV8YRyYss+yS
	 pKaKRczbp3bwxeXMgaHLtOOJCpNefqHPLQnop5k9T7q2wNqFx6GDqyevDVPhUxlNge+j4
	 jryCnKjVN02pb2iBAFCUngvYUO/Ockd2Z0nZoM6T71wULw3LeLrF5akFDSwiHg8al8Mls
	 +nskNS/KzgvnKU1IPstMJu3WQ1tt7R7D1ZUf6WCOxXwyxPUzmVsJE/jUXpAurAPIPzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KSjHQFyR;
	arc=none smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B28606BF88
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 19:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4B28606BF88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KSjHQFyR
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-677d35fd1d2so1454816d50.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 12:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793214301; x=1793819101; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HBeP0TSiYus+H+GGePP31NmAMp8IAFuLA0XNaEeXXiw=;
        b=KSjHQFyRR+anaK/fnGmAHtjEQik171LZhKrmWu3Ns46obZsve5dZLtWfXrCrMzuZUI
         LG4QoLVrLgPUSyw3GCGhOQhu7b3GTbE2slNwbVghfQ8LWImuxF1V6gLDIPkPVPZvpQLX
         1LhXCdB9QlCagXedmUtJAC98IqMbuk6D9p/vlrRRB3dr2eL5pFL8r5ss4rhBegxTIbKo
         M3U5XFw69zLirS4U6q/XRoq/XMHIKtTOUI1w5VS1HVVl5pDosD0Lr+vDmKWElubIHuL2
         duq0i5kS1U/MK+SIoqJiULYP+EgqDZLX28Z2WtdW6U5YCsbFHshoJ4t4O6pfWQ3RV+oO
         CS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793214301; x=1793819101;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HBeP0TSiYus+H+GGePP31NmAMp8IAFuLA0XNaEeXXiw=;
        b=HehQuwDYxpksOgaK5lQE8qF10zb1r8bXCXrJUEfnzDf81jNy5neqW9Kaou9nR8OzVQ
         BoQ53WI6nHniv6a/LO1S8vU8HAa0be+SmPG2dxRTTse6sLhqKSRe9djhbZKfupoUrFSr
         rPS64nF08qrx/Ba10Q2EP6SvqWkjS/XZXrNDUhB7aqDIZshKpZefqVpyVv+nNwfh27zJ
         exagofpEVmPL1eoTZkCpGIkrsmGF+DmgKNcj/ReVpF4T706K1Gd8s5MOjiUwQzZ4dszg
         syAeVg1BnsqRSD/KEQyrG7T9KulTiQI+EOQ3CaRz/lag1A1h6cCzK62O8tCQZUoX4Dqr
         QxUg==
X-Forwarded-Encrypted: i=1; AKwUvBypzYBDCD23YMeFJ4KJ/RbkK8s8SMVoXa7ROiqImlNz/73DxfLWLGgzcc66wDClGBByG/wZp8Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZvUK+wyD3qPQ1yjB47MeLqaO/sxizjcJK8CEtIt+D11JPy9gv
	2CcpxxScbU4qnYrpT6ZfuJb/XTkyi63lzh6xUZgFvc2hM6saaitXSjas
X-Gm-Gg: AYBFou2WPXdD0GksUSqtNsv3Of1GW4DSV1fTcqZzHcnOlxF1MRQVjCjctJQVDErv09z
	uXhnTMO7rxbxOcTQ3ZDQPZmKs/5bTrO605L1GyCXVP+KhAPQr9ATxywnjVPhuwzgiJ98D3ac/UO
	DF0gZ1qvTRTYlFZiD9WOIuvRkZhJ49w9qCuSctu0/e6fxtQOke4gahRdSI1sAjoqy/ay46rmEkk
	7YT6kCRtu7Y7Ifr/mWNlvkSZfHUBLo+NDM8o8BRR8w6mvBRiw5f0DtyBkRdDIT1LqLUhhGWJrX4
	Iod8WUEsKLhmmOYCQbhF9np2dKeZaTqnyHGX9SWMaU6xfNvup4yj3eXc76f3AKTLToBaaq4u6Vx
	KocXv29ErcpRM6SSAjbyc/MAtVB4eU1mAPM9/Gx1GPiRg7Sk1+CIkSLNeh8Wzvc0QWrMIYDrCgi
	+zCkvCQFW2RF51Ffz2rbQ/rQ8G7ZClRdCG0Kh7LISj5vZK3QNQR+xY/4BcVCipmkGLKG1RNwNzj
	Qt6m8B/GSYSjbFhKFOadkQLhpC9loOz6RycrnuslU8Ph//xzUoHZLcVZedkycbQy3cKYnF8Yk04
	3AzueL0918WT6sTVu8GSNzAe7VgR2qXuyrBeyxsoCQj91jgoROjxg6metblP2koBV3XNVezTThl
	XkTr/OjDYKPSFndvGZHsjwd7D5NXmiLbFKebpio1JOCaQFnPV3HF7964E3+lGriyxcaeB
X-Received: by 2002:a05:690e:2061:b0:672:d32d:999 with SMTP id 956f58d0204a3-67a7b9b9f21mr1560991d50.14.1793214301294;
        Wed, 28 Oct 2026 12:05:01 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a803cdd1asm1434191d50.4.2026.10.28.12.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 12:05:00 -0700 (PDT)
Date: Wed, 28 Oct 2026 15:04:59 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 dev@openvswitch.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Ren Wei <weir@nebusec.ai>
Message-ID: <willemdebruijn.kernel.3177102d5612b@gmail.com>
In-Reply-To: <20261028122703.2093730-5-edumazet@kernel.org>
References: <20261028122703.2093730-1-edumazet@kernel.org>
 <20261028122703.2093730-5-edumazet@kernel.org>
Subject: Re: [PATCH net v2 4/5] openvswitch: use eth_type_trans_careful() in
 internal_dev_recv()
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> OVS actions like pop_eth followed by pop_mpls(ETH_P_TEB) or pop_nsh
> can expose an inner Ethernet header which is not in the linear part
> of the skb. Output to an internal port then crashes in eth_type_trans():
> 
>   flow: in_port(0),eth(),eth_type(0x8847),mpls(lse=0x00010140)
>   actions: pop_eth,pop_mpls(0x6558),0
>   # AF_PACKET SOCK_RAW on dp0: eth / mpls / eth / 4096 bytes of payload
> 
>   kernel BUG at include/linux/skbuff.h:2839!
>   RIP: 0010:eth_type_trans (include/linux/etherdevice.h:635 net/ethernet/eth.c:163)
>   Call Trace:
>    internal_dev_recv (net/openvswitch/vport-internal_dev.c:202) openvswitch
>    do_execute_actions (net/openvswitch/actions.c:1296) openvswitch
>    ovs_execute_actions (net/openvswitch/actions.c:1606) openvswitch
>    ovs_dp_process_packet (net/openvswitch/datapath.c:310) openvswitch
>    ovs_vport_receive (net/openvswitch/vport.c:448) openvswitch
>    internal_dev_xmit (net/openvswitch/vport-internal_dev.c:42) openvswitch
>    dev_hard_start_xmit (include/linux/netdevice.h:5455 include/linux/netdevice.h:5464 net/core/dev.c:4057 net/core/dev.c:4073)
>    __dev_queue_xmit (net/core/dev.c:5066)
>    packet_sendmsg (net/packet/af_packet.c:3157 net/packet/af_packet.c:3189)
> 
> Use eth_type_trans_careful(), and drop the packet if the Ethernet
> header can not be pulled. This covers all OVS actions at the consumer,
> instead of fixing each producer.
> 
> Fixes: b2d0f5d5dc53 ("openvswitch: enable NSH support")
> Fixes: f66b53fdbb22 ("openvswitch: New MPLS actions for layer 2 tunnelling")
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Reviewed-by: Aaron Conole <aconole@redhat.com>
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Tested-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
