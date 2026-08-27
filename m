Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EEA4772B9
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787841313; cv=pass; b=T9q6SKX7cGQkbUn3r2T1QrrMLFoAUp3KsYa1QD/NwgEwdP3856S+vncX58EwVqx3BDA5PfhNu++NW2r3P9jX+6E54qKY1rzHBr1/O4lJ4hqQDsqih+CfOBtsotpbyy6CVcLD1hEkXduwBp1nTvZzepNbMi0p9W6BYy/Ld7Q5+oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787841313; c=relaxed/simple;
	bh=xEUOQjzcIybzJYFJawf+kUHJLd5w+JO1LLWoXSKKkHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eySzUc+NiKpVyIoDEL3EJmDaeD8ooGZVb5uoyPWN5BSEwAOOqoM4STIAxE5S1Rbw9FQ0nRxHSAYAcx4HJE1VAJjiBpGrWi5gNQ8ILv9yq2kpSlyuZA/7yhaVQUeJHF2xyhpFMkvBFrO864vCxY+uHcbWa5Mp4ydrkmzseBLbI3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gwCivuz+; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gwCivuz+"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-52fa223df07so4463731cf.3
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 07:35:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787841306; cv=none;
        d=google.com; s=arc-20260327;
        b=DUeQSySGcFi04hB44Gtdz1BpK9Ug9rcCI83FHpxplQd/lCJ2Xr66ckmAMCCc6zubEh
         m2OXr9oz2jdQh3XJeFwZEINaTH3SH/kTjT6gaWG09xAQmSazAtzn4IGQNEt+bv204tH+
         NlUgWLafkvHfGhwW4ehnwwbu+LsRmhnOpsX+Tg9DQ09jQ+V3Hlb68NthvSwSQ2o90nPr
         6E+s6UxzXbeZME3LEk4cL9SPuRN3KzLAxp+LELcI9+pdLLdugXqTdynSrcKkETF0jHzf
         0kjtUqZznPkpfgdZUoU0XOp5ssZQB2LTepE/34hXe2sH4sZOKedOC1/H9JErW+S3Ri86
         4gDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xEUOQjzcIybzJYFJawf+kUHJLd5w+JO1LLWoXSKKkHk=;
        fh=82Qm2jUiepMUhL90sMV0xvce7Z1bOSFGH9MOVZC/0Uc=;
        b=DjLU2uoYsLoWLoTlHuA8FnoFW/iFJuLorQWTkug03blEA4vwHWykNRyhZBwl649hII
         ikokhe+5BCmQhiSGWgxkWOMHJPWhOvrxYk3adgjZ9bZ0bUM31j4roLfQCuVveAiz2S+d
         KOPc48+Be4x5+sRWPTJPisTt2lFH0seOjxt4GXE+HwgamHk4stzw8mauYtr8qZ8t+ENs
         gM5NShyT5Zv3eHVioDZZvkol27O+yMTrFnFO7yCBA0APo+KKCdKCvj5qjf3LjttVog9i
         NPW5YP4MhimsdnLs3qts/KFd1puexvsxbfoU2tVCTkKGokjyOKn04TGzy1gvXHnachtF
         rIiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787841306; x=1788446106; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xEUOQjzcIybzJYFJawf+kUHJLd5w+JO1LLWoXSKKkHk=;
        b=gwCivuz+CBahdhBi/bR+M4Wf5qbC3z1HJd7acKcg6I9/bZdU2P77wKmGFEpuCxMwWH
         qXPr8ui2Y3ApxfukwoOn+9+JJLhBw1MZbdKWEvvUIETieoAsBq5b0sMquWEA62meYmlk
         1xzNWFRvmpSK7+E9oFiEz3Q51lKlTiw4oyERdmRT27AnCdL6Ps5AaKZ3llcHV0dSOj2k
         HrjGSeEZz2kdY5sf6FOjAN6G6nZA56ZPHfRaypmbbejaL5dGFBYfjW9bJ1e8OtISmnHC
         zZopF3Ttl5l7RtKRFg66Lx1TaMo/cv+um5b3hOCf/7sMtDNWluRZgZb1GMRUYVVP9vAY
         YHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787841306; x=1788446106;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xEUOQjzcIybzJYFJawf+kUHJLd5w+JO1LLWoXSKKkHk=;
        b=fy37oyW33mRLZcuyw+p2BdhqgnHtW1z+Zkb31PXs3e3he/ZKYFJoYF9fGZXtE/zBSB
         gmv5QuPUgqYEjsBesmUQ0Y7Xglk93JGhEzr0BMtsnqjWetnUKNUvUUwf7meHxEFPX3wX
         Wh81qQNXf6N0Qnrt8s2z7QLYgd0jlaYy5B3QXme70kUSY/Ws6wqyKm2BgFvUvjD7EDU1
         2ZNKIWUIPUNCccQ4zKfbPTqQdc9JGRwnU/yezEJapnmgJ+QIWgCF14q+jsSBl1roWary
         c5VRyIXSQ6U2CJ3knao93sQz2mP7dgfa1WaPcTCDdOyVC4B5KQ9Sn/sDkWoJq0Mz9Oie
         q2eA==
X-Gm-Message-State: AFuF++msbnMqc2QEj2dQ+zQYQ5TBnV4DlzsqjSQ8NC2W+qNjRXpxk2oQ
	eNcFl6YNR+mKQQ5hMVpYLLy6c1dc5rnUuyRhVr/Gek50zczeTtqKtiJvdaB4zdk4T4L+WTAd1Jg
	1a1whCB112PJWZ/5l1AiAkxkS2CqPlK0MdRipcOqV
X-Gm-Gg: AR+sD12AnegFq2PrC+Cd0GWGwz1gBJZv7/Hgs2YjI3Jq3M0CBIkzjTStRIavAnsEDiN
	VzH+VvmUMEA3sROanwf/OSeWUEg6C8nW0UI8STWQ8M6fefh3iVaYCJJPDftqQa/an/DS9+J9QJz
	b/KZNARE+9oss04XmpYfP5ODUJlaICGGFZ+ZCIxMaLKm0mfqFi2DC2wDtM4py4r4iOnhgv6EBb8
	1IsxAJ3gwsbo6HxMqdawrYAXLYwZeQT7D8DrZeCRMOQ8WaKxXUPijpkN77Z4napJZ+HVPTQi5QG
	k9hb/K6UCSmFzG1rCsPkJYyUtMen+ftpsGMXZ+Cu1F7sHtRZ5beGuO+7MhgvzMrZ2nM1dSGThlS
	iCxce9DtlAbRtP8JZwb6t592uN4xzol9L97QjDP80AcDJwP1sf7Le5ZT0QHk=
X-Received: by 2002:a05:622a:8c02:b0:52f:64c4:8094 with SMTP id
 d75a77b69052e-52f64c48c14mr95183931cf.39.1787841305546; Thu, 27 Aug 2026
 07:35:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <937926e509f2acd8e0e66520dc2b30fd6b4d1687.1787839506.git.pabeni@redhat.com>
In-Reply-To: <937926e509f2acd8e0e66520dc2b30fd6b4d1687.1787839506.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 27 Aug 2026 16:34:54 +0200
X-Gm-Features: AcwNN1XvwVPYw4-DM72tIlKnOvF5uwNITLKgRkuBK95DG4I5U_etVVB6MBsvwns
Message-ID: <CANn89iKO2-p9Jg9rbMn-=yDz8=oRvxpkz2ZqJvsgWQqK_HpX2g@mail.gmail.com>
Subject: Re: [PATCH net] inet: frags: strip GSO state from fragments before reassembly
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Max Krasnyansky <maxk@qualcomm.com>, 
	Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 4:07=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> From: Xinyang Ge <xinyang@anthropic.com>
>
> A virtio_net_hdr (tun/tap, or AF_PACKET with PACKET_VNET_HDR) can mark
> an IPv4 or IPv6 fragment as GSO; nothing relates gso_type to frag_off.
> inet_frag_reasm_prepare()/inet_frag_reasm_finish() keep the first
> fragment's skb as the head of the reassembled datagram, including its
> shinfo->gso_size/gso_type/gso_segs, and chain the remaining fragments
> on frag_list with whatever linear/paged layout they arrived with.
>
> After ip_defrag() (ip_local_deliver(), nf_defrag_ipv4, ...) the
> reassembled skb therefore still claims to be GSO (SKB_GSO_DODGY), and
> the next software segmentation point - udp_rcv_segment() on local
> delivery, validate_xmit_skb(), or the ip_finish_output_gso() slow
> path - hands it to skb_segment(). skb_segment()'s frag_list walk
> assumes GRO-shaped input and hits one of its BUG_ON()s. Two writes to
> a tap by an unprivileged user in its own userns are enough:
>

Reviewed-by: Eric Dumazet <edumazet@google.com>
