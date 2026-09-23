Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE85738D6A2
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790173410; cv=pass; b=ggTdck7OIagUqLJOStclAiIKtkrnjyBbERDM/QQqA9j92WBV7B7XHywfIQ+h/kEaAA4nriVaExhxVMokAqw6PgYPQZJWDWgCNYe0/M/XQXXraj/Tylb7nN7Io8zbgSZPcK5oAjw/G/ersLVmWHLRnFAPphgtOwD5xk6xcqju72E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790173410; c=relaxed/simple;
	bh=gahBeHvpwkmCZN7wJgEDtK7m+Jh/or0CY/c3PCC6rsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSMEGXvkYo8Si0aiAf/mv27d3VORxqUFV+UIvRLhT49vyyjsVKMVTqnmKKvTJ9lGDaQFOYkWv31Jwn5LkeZVAQGcMqkSvLyLct5UCWytIfnrhPZUm/q9D3HvxyAhl2lflckuw6D5QHpF6YkYPbch/isJr3Fw9M0BxkMVtpdVkSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OyFaiG9N; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OyFaiG9N"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d43da99easo12992967b3.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 07:23:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790173407; cv=none;
        d=google.com; s=arc-20260327;
        b=lFWvX0/zYtBdLQ1/F1w5IbaJ/HFfQmE9cas03Md1F/W4s27xirj3DRYqkqSI6ceINV
         fcKpleUFqg+oKx7qcKMQ8zv8tBhX42IXibMy9iM0L18VIlIee4B2GsNHVntQokVyC/NV
         LhWFOk18mvbde0JUhv8wM3fhnKimj9GrgMKeBqns4anYdpDPnVHA7jsqM2hBxzSforGM
         qjoGMz4N8hemUSBmv14ayksxuUoMk8WFEXwVJZ2dGlmlljoUxGwlRim34fgPDr46avk4
         /hdEN0OJAyEJjTc9sOj1QX0Yo5I9Mr0MSIOoek73V7W2zz0X8EADS60ac3BErQBEf2cQ
         da4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gahBeHvpwkmCZN7wJgEDtK7m+Jh/or0CY/c3PCC6rsM=;
        fh=MPxEi+mhYrJ2F+AzZWvK1N3e3LNQGK5FVNDo4LivLb8=;
        b=cTfJh8RgNi08nG4mFVeMd5HJM/xtSpYPqgE0lgbUy5EsNO7IC1icYn3rtnG+takhnR
         9IrTcILsRq/eGNt+oYspxODQE9PKsRFwJ6L+NxOz2tGZ/doE8NgdE6mJkSyKJ+qh59PD
         Ddu4jojREgjusdnxneTJt6K9MEEUZfHe40+IbjSFkgXV20FkIKqaWti9PjXXzXIuPPG/
         GCMURPD1tm64BVwDSoQe++XecqmmOOJNicb61lNNuV+nxalZW8JbcHlhq7N3efdjvw23
         mkxi3XQ7iXfXh9L7wWHb+04TFE40MB3MAEf2RNWKdgNUtCk3hhWoMmamF+lITRxiwUY5
         Ze1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790173407; x=1790778207; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gahBeHvpwkmCZN7wJgEDtK7m+Jh/or0CY/c3PCC6rsM=;
        b=OyFaiG9NEd3FnzVPfmulV+PQqtv3dbhhvLcJTtdkaFdUdGU0y3Rk7PSjmpmn0AJN1t
         x/0Xxp/gL5yirPR3tAQXN64BY7Iyvf9iLocnhm9rt7T2ygSO+gcZkOM14TB/tEJdmlmY
         2tk27gQQdfQACFG9lhH7YCm7aZh4VfJclvN8e3CKVF5jsJNCEjlqFLbCpW2T6H0WE8Cf
         VBSZJ9bHVjoBqdV5pSOyRb6oRFGUVN19BXK2/5IvDcapy/qEbh2Iv2zmp34ZmvCKRnxl
         VRsnMOGxdWFFCTsrLMyfOvzOKxWZ1XJuipT2FdThJDPRZZTrmCKtwPbxurSY+/cSq6wC
         LNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790173407; x=1790778207;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gahBeHvpwkmCZN7wJgEDtK7m+Jh/or0CY/c3PCC6rsM=;
        b=i/BdDHs7r9fqBEChQsjZy6gJbTIRWPdZMYG2g5OVSWnnNbEsyoyX77TwYm78dBndmk
         mETYfX0aFG7NsU9/1hduEj9MWNLFDBu8F35SN4a46QeJP1SxNhqHlcWuEBeSLeBweMMN
         jtu9cGblSo8m8Fx8ANdnu56kEtipSEJwlNjs28whcJAmt/tycjJAYxey0Ezu2BVeUNMt
         rx4PdQLP3RUl0A/tNxtS4A3EUwFBfchYz2NzSk7BAYdpuWyBap5aSA46p2r0CAkM7YT+
         R8kEYYn4pL2azrJhLJXVLLlrzbC1W8a3J1PNRaJlTdT2ACQt7vTCT2GebF9D+Kpy9bMd
         qxow==
X-Forwarded-Encrypted: i=1; AKwUvBzXbsZWKUClW0iH8dJJYL+uz9/oy5vQ9LilBwFABFqsJHm+RInkXQIPqV1XJ4KdO/yqdS2Aa2s=@vger.kernel.org
X-Gm-Message-State: AFuF++mFwlakgeNkot4YKkJKygrepmhtrFxlNLBy1eTyJIGJeSvfIqfD
	xoIQU66IeKXLTQZBRpu0rNIYdcoML3dwbIU+ezUw8nO6j0pL+WrmfdoEShfukezeoKgmyHFMYBW
	bNxW+R6Wh3dUaHyD8K/CjclHvImq4nnXkjGY7kKVm
X-Gm-Gg: AYBFou2FIESQHyyQRBkqS5gjj9SzQ33Yh2eSmrELXvsx12J4tLRS+iEhdNnBv62QiAn
	PQLeGcsl3aIU3ucAWNO5ePXtKR/yuxBUJa5I27P4y++7rnDqFAuFYhEPgkRU2LA+UvaEgJwcSm9
	11pvPuJftqj17KxDbzj+EKh24h6RcruBHraySxeHORZYVzeDEjRP0FOZM1k6BCUwWFNfEjTeR7P
	609V7SqVm5AExvl0JwA2mfbV6UGc6u3E4lwGaUCTTvKQPk8xbQTa7gh4jbioOvl0xbsCHzm4lYL
	d93GPptbL2Dkxvrw9Qlcm/3fS4aRZPjDOI70fqfKyHwRIYQdAdAeUBKSPCz7I5OFuDSRuFly2QN
	uL+zxHIJ/fB9pu7jONkw2tLq0MYJYiZJxBK7Af3vuKDqk6yF5nO1pYwPZFwM2t17aRYLE
X-Received: by 2002:a05:690c:385:b0:892:fa17:aa28 with SMTP id
 00721157ae682-8a458b22d54mr12803967b3.20.1790173406059; Wed, 23 Sep 2026
 07:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923141047.14047-1-hannu@varjosoft.com>
In-Reply-To: <20260923141047.14047-1-hannu@varjosoft.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Sep 2026 16:23:14 +0200
X-Gm-Features: AcwNN1Uw6x1C2DgCe-AKPurmMSH3BQ-JKGsFh7FS8lfjdLGw6nlcv1k6mmolgds
Message-ID: <CANn89iLq9kyTqUW4w46wjKNNr-n+jypQX-3hwPE2yjtSkLw00w@mail.gmail.com>
Subject: Re: [PATCH net] gve: DQO: accept TSO packets with non-protocol
 gso_type bits
To: Hannu Varjoranta <hannu@varjosoft.com>
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ankit Garg <nktgrg@google.com>, 
	Willem de Bruijn <willemb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 4:11=E2=80=AFPM Hannu Varjoranta <hannu@varjosoft.c=
om> wrote:
>
> Since commit 014c607f86ab ("gve: add support for UDP GSO for DQO
> format"), gve_prep_tso() matches shinfo->gso_type exactly. gso_type is
> a bitmask, though: SKB_GSO_DODGY is set on every GSO packet that comes
> from tun/tap, packet sockets or other untrusted sources, and
> SKB_GSO_TCP_ECN and SKB_GSO_TCP_FIXEDID can be set as well. Such packets
> hit the default case, gve_tx_add_skb_dqo() fails and gve_try_tx_skb()
> drops them, counting them in tx_dropped.
>
> These packets do reach the driver: tcp_gso_segment() passes DODGY skbs
> through unsegmented to devices that support TSO, after recomputing
> gso_segs, so drivers must tolerate the bit.
>
> This breaks virtual machines behind a tap on GCE instances using the DQO
> queue formats. Every TSO packet forwarded from a guest (gso_type
> SKB_GSO_TCPV4 | SKB_GSO_DODGY) is dropped, and guest uploads slow to a
> crawl of retransmissions or stall entirely, while the host's own TSO
> traffic (gso_type SKB_GSO_TCPV4) is unaffected. On an n4 instance
> (DQO-QPL) with a Cloud Hypervisor guest, a 64 MB upload from the guest
> went from a 60 s timeout at ~0.9 MB/s to 0.19 s with this change, with
> tx_dropped no longer increasing.
>
> Restore the bitmask test that commit 1b9f75634441 ("gve: ignore
> nonrelevant GSO type bits when processing TSO headers") introduced for
> the same problem, keeping the UDP GSO support.
>
> Fixes: 014c607f86ab ("gve: add support for UDP GSO for DQO format")
> Signed-off-by: Hannu Varjoranta <hannu@varjosoft.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks for the fix!

Note the breakage is not limited to tap/VM traffic: gve sets
NETIF_F_TSO_ECN, and tcp_ecn_send() sets SKB_GSO_TCP_ECN on TSO skbs
carrying CWR, so plain host TCP with ECN has been losing those packets
as well since v7.1.
