Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91AA4EA38C
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415082; cv=none; b=Ag5OfIBebOI7XLiW4dIrxhZ6HeVYDzJcekj9VM4I3DvffM67lOJMaviLYX9C01vWmvnPL2xoQJeQVP4ZNYL26YFjOqLRoQiqUHx2y0ngGO4g8TAPsNxExGRbuZREhDpkY+/OjZVnWbFWFwdvdHVOog+KNGO/XYFKVB7z2hnHteY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415082; c=relaxed/simple;
	bh=ypi3osWI8gP8xyKWXAity7kWnhHwA/VpXlB9i/wvPi4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=PwB1MAFMSrWZOeisqkWEsB/dR2WMHMq2nTdrYHEdmdjV5Po/+03V1BHxbSEv8T9T18faIO6sJEQFFOiglq9kFtQaufYNSoj4B0g0g1InCl584a+vJmhQgYTUx5MFWVj+7f6YU6Q7/hMip5hMyhdwD9de11TWrMyk67RM92sUO0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zw2Ro5NT; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zw2Ro5NT"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-930c0f9c1b1so207376085a.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 06:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792415080; x=1793019880; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ypi3osWI8gP8xyKWXAity7kWnhHwA/VpXlB9i/wvPi4=;
        b=Zw2Ro5NTFeqeRpPaUDiAoqDBBEVA4vrR/egIYDXbODNDfzxRKXaLD1RJK11z0W2Nfo
         v4ChuE6+1Sfi4K+VMqUl/ZYJB0btqAXli5pJHKqFcJ5+/uVwztEMPyj+J7yGeSc02FBk
         C6CLlRLhQJl0jM8HTwn917o5vL1wfF9ZSDi+dhXi+InmnwfjUMcBIiA70sapE8VxKTcE
         fF9GSx6VUK6IsUY0dHiKY4mYq2w+na9GwH3Hpjy1mWZGcO69wec5JKb27RNOnTs3sqsM
         01rhQF+lRKg5rrHh7r063fn0ukbU+Iv3/sufzKGp/PEF1gaM6y90GfQ/oOuPO+W+XT/y
         jCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792415080; x=1793019880;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ypi3osWI8gP8xyKWXAity7kWnhHwA/VpXlB9i/wvPi4=;
        b=jMQnOSKRlObeEfJtGNxDZDU40Z8WcsH3ItTaMnQP2rwcQ23ZMNhpkksNUaEIJna1my
         JkAw/GNZQ3MGc0DLFI2gAKIw7b2IOPs6X95qR4gjXW6FZ/oBhAKElLhG+d1hcFnEhgyn
         NwApnWIlqAlrtBnc+sY+HoMketC9k89BKyZJQgwFEfTHWsBTvr+Zo26zEeZva6RaRKez
         dFxhyeVaJkRdBW9lK2DGofsY4dlseSluy/DXguO+8j4ZG5QeQtj56O3mfuxJzD9Vc0mS
         95NO3d44E3YnC1UE//xk6s9DUEouHDWH9Ck/ppVuLM64KnljiM37iioDDgLa/B84TGQ8
         J6QA==
X-Forwarded-Encrypted: i=1; AKwUvByRqnO3KZkIJunR/FsFHbEsPqJ6giLKNvS50ndxNJuTs8XSde90deMD3cp42EBx/AGMGLuzxwc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLza26FZ2lzIlEZGvlrRFEYRWkBY/RoUiQt4egy5T3ey06SiBnT
	2MG7GJSKyjJfuEoPjRLYt/LAwyu5sxvsumfHD/mmsPj+kabLnTIDaRcf
X-Gm-Gg: AYBFou1I+e7JGOf8nmDzhzsBpcpSWNyCC1Cd8VM1Y07rIMZBZpA1rVFWSbT6rvyDtNi
	m4xyZgix5GVcRJH3aSztYrQ6Ki0WtZ963XSODYOY7Q8+Kg4KKh8FH2v00MmjHLNYYhTrzouY/VW
	A8M/bo9cJIHD9XVgoWn/WWUEnldyX4GCaVcgVsouqIB9gPixtn/FG/f/zYslCaFnuASoIUHClLv
	+EYgkOpJf+66IjLxHJVB2CEtEm8GoU9tRgbJdfZnGr3kfpYYR+VVW5KIzKESFAnoKOMyT4YEH0a
	3pw5f6Z8L2UejsoiEV8uyog3m3TLKPl4AFLvN0Se/FUKJhJkmZotpaofyrVVBT30fBQdtx0zkLT
	SUHcCuYoSk5zrycv2WJccfWUWHjc087MExfEWrgHSrBCI9WrNMOzUQ9tCqH63E++4TLzue8k+Ns
	v8f63TPnCjdgK440PWQ1oi+m7cjWfUvTSIAJaqvSBfjG0ir9IHHPPSNmybd1+lVUMTdWeLPd5JC
	qs=
X-Received: by 2002:a05:620a:7119:b0:93e:fc4e:c490 with SMTP id af79cd13be357-93f29cf1c9bmr1378673385a.15.1792415079619;
        Mon, 19 Oct 2026 06:04:39 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f3cb855a0sm328418385a.4.2026.10.19.06.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 06:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Oct 2026 09:04:38 -0400
Message-Id: <DM8U47F4MNK3.2V54CCQ9YTNBY@gmail.com>
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Daniel Zahka"
 <daniel.zahka@gmail.com>
Cc: "Alexander Duyck" <alexanderduyck@fb.com>, "Jakub Kicinski"
 <kuba@kernel.org>, <kernel-team@meta.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Paolo
 Abeni" <pabeni@redhat.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Jesper Dangaard Brouer"
 <hawk@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Eric Dumazet" <edumazet@kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/4] eth: mpnic: count packets, bytes, and
 drops per ring
From: "Daniel Zahka" <daniel.zahka@gmail.com>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261012-mpnic-counters3-v2-0-8afba81c2d5a@gmail.com>
 <20261012-mpnic-counters3-v2-1-8afba81c2d5a@gmail.com>
 <20261016220930.i32JEcqe@linutronix.de>
In-Reply-To: <20261016220930.i32JEcqe@linutronix.de>

On Fri Oct 16, 2026 at 6:09 PM EDT, Sebastian Andrzej Siewior wrote:
> On 2026-10-12 05:04:34 [-0700], Daniel Zahka wrote:
>> Keep packet, byte and drop counters on each Tx work, Tx completion, and
>> Rx completion queue. Report them to the core via the rtnl_link_stats64
>> interface.
>>=20
>> Rx completion queues also count errors. Frames the device marked with an
>> uncorrectable error are counted as errors, and frames that fail for any
>> other reason are counted as drops.
>>=20
>> All packets cleaned from the TWQ during mpnic_flush() are counted as
>> drops, though completions for some of them may have been DMA'd into
>> the completion ring between the time mpnic_poll() last ran and before
>> mpnic_wait_all_queues_idle() returns. This is done for code simplicity.
>>=20
>> An RCU approach is used because ndo_get_stats64 is not called with the
>> instance lock.
>
> Why do you have the two mpnic_base_stats and fold the stats into into
> it? My guess would be that on stop the counters are reset and you want
> to preserve the stats.
>

Not sure I understand. I think you are asking about two things:

1. Why have two mpnic_base_stats?

To avoid a separate heap allocation that can fail. Handling an
allocation failure in the ndo_stop path when doing the aggregation into
the base stats is tricky.

2. Why split stats into base stats and per queue stats, and why reset
the per queue counts when the device transitions down?

This is the way the stats in netdev.yaml are exposed depending on the
'scope' request attribute. My reading of the relevant kernel docs is
that the per queue counters are counting events for the current live
queue, so it makes sense to reset them and fold those counts into the
base stats when the interface is transitioned down.

>> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
>
> Sebastian

