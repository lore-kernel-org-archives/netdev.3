Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792979231;
	b=qCeoReABIh0O+lAyVhs6aCmRXA5q5h+UKVf9y5ChbybJLaLzhQ6hBkfgXGae1ClGXgNC
	 jnYtnsW44sOR/Kvq0zta5qah7SIEL22MIUVjGDhyd1nERatrsERkI1M8/fZdzySMIhLmZ
	 uvyIWeXRWYn3GuDjyxMdLx7obyCvx9zV78bkDIiY49R+SDFTkdHRLk5klHp5RMwP3u3Wa
	 yNgcO12E5i0LJKWnscKIgsgAu658/s5tZoJeJV07a1VUw8Yp4YdWEnaxjOfgfrZUdAgmw
	 i3OOKD854hOH/wLFc17MW/S7uwujZhrZmDxl+MfIS5Hs//YBNsUdF6lVSW9E2XP2bfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792979231;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=vr8X29dQrrQJKmK5OdQoBdcR8wKwrCCJ4tUvXjR0kCU=;
	b=bA+rH0hNdTJbDPZEhlSrmTYfWVeQRGgBbfiNR8D+i7yWZBSfsNxnDSLsH+vh78QCRgBG
	 1o8N4Ku+UaL/LZOLgbt28FVGcPS/sTbS5RNrIEkLZmuFz6su83IkuBnVQlOR3idxH/xju
	 8oe9L22VSUFm43qbJcc0iyNPhqgVGhxhbEwtkyPAGs2GDeQOhEsamfut2mctFMDrRjDkX
	 rWh6H7AyfsU+qoKzaGUBqTmagDkUDM26DeRQwqbu5IZu8x27nU3M7amDJtuZhLQ9B9/JT
	 OCK1EqvPsnJUeLuUVvYOEYuhg2HoktK7DtKkmuver9vdQA6IAmveA1MDNSqNt5EQN/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eaFqB4uV;
	arc=none smtp.remote-ip=91.218.175.146
Received: from mta0.migadu.com (out-146.mta0.migadu.com [91.218.175.146])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BDC606A31B
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 01:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48BDC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eaFqB4uV
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nzYtk9ThRxKUkgTRTXSdCFqFhEwm/Eizg/eT16xq+V0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792979228; v=1; x=1793584028;
 b=eaFqB4uVTtEesZwscubNwEiLHXvdm/3BjaZga40Pb3ThZbD+krDzIX+owscspXJIgn/4lirW
 1vQwRvZvxTpSGH90evMtP1ePJF8sENgOIoh6Ey4EJDs5zji57A5sNE6IW2GEt7O/XjFHqfP6NkO
 z/Ho4lA0ij1xVbR5aQTv+Zlg=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 5699498c42138b6c;
	Mon, 26 Oct 2026 01:47:08 +0000
X-Mizu-Trace-ID: 5699498c42138b6c
X-Migadu-Flow: FLOW_OUT
Date: Mon, 26 Oct 2026 09:46:59 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Justin Iurman <justin.iurman@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH iproute2-next] lwt: ioam6: allow options in any order
Message-ID: <at6xE1zwuKqeO8yv@fedora>
References: <20261022-ioam_fix_order-v1-1-6eac1e00455b@kylinos.cn>
 <1d0887eb-2ce1-4768-a1ee-6c05a0830f52@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d0887eb-2ce1-4768-a1ee-6c05a0830f52@gmail.com>

Hi Justin,
On Sat, Oct 24, 2026 at 05:26:28PM +0200, Justin Iurman wrote:
> On 10/22/26 04:53, Hangbin Liu wrote:
> > From: Hangbin Liu <liuhangbin@kylinos.cn>
> > 
> > The ioam6 encap options must be given in a fixed order (freq, mode,
> > tunsrc, tundst, trace, prealloc, type, ns, size). If a user uses a
> > different order, the command fails with a misleading error even
> > though every option is present:
> > 
> >    # ip -6 route change 2001:db8:2:1::/64 encap ioam6 mode encap \
> >        trace prealloc tundst 2001:db8:2:1::2 type 0x800000 ns 0 size 12 \
> >        via 2001:db8:1::3 dev dummy0
> >    Error: argument "tundst" is required
> > 
> > Parse all options in a single while loop instead, then run the
> > cross-option and missing-argument checks after the loop, reporting
> > the missing arguments in the order the options are documented in
> > ip-route(8).
> 
> The current order is not arbitrary by intent:
> 
> 1. freq
> 2. mode
> 3. tunsrc
> 4. tundst
> 5. trace
> 6. prealloc
> 7. type|ns|size
> 
> While I agree some could be swappable and the above order is too strict,
> most are dependent on context (i.e., a previous keyword). For example,
> (type|ns|size) are only valid in a 'prealloc' context, which one is only
> valid in a 'trace' context. They form a group and their current order should
> remain inside this group.
> 
> OTOH, as mentioned, some could be swapped. For example, both tunsrc and
> tundst could come in whatever order. However, they are only valid in a
> specific 'mode' context, so they should appear after it. With 'mode', they
> form another group. 'freq' forms another group by itself.
> 
> So, I guess a new accepted (relaxed) order should accept groups in whatever
> order, but the order inside a same group should remain. That said, I'd be
> open to this proposal if other iproute2 commands also accept parameters in
> any order, regardless of their scope or dependencies.

Thanks for the reply. I agree your explanation about the ordering makes sense.
Personally, though, I still think the ordering constraint is too strict. And
the new patch also validates for mode mismatches and missing parameters.

I’ve checked all encap types: only mpls and ila require the address to be the
first parameter, seg6 has an error info about the tunsrc order. All others allow
arbitrary order.

I’m fine with keeping the existing behavior, as I can read the source code and
know the order is fixed. But new users will likely hit this same issue again.

Thanks
Hangbin
