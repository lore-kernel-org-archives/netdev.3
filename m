Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EF6386561
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 03:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792122450; cv=pass; b=bXsgnQbhljhcgjITaTK5YAiuqG1KtURfJP1Kqv5dK4plvckBGrpV3gb8i0e9QBRQFXWHvmr1GI3ONm43sNX8g4cyyRs+tdAuSHNMAMzztE0emyB5SKc0eZA6kckt2g7X72vlxcfJkG1zfKmGDsGQnkn2rWExwB//ZYo50uZ0SHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792122450; c=relaxed/simple;
	bh=yIqaxTNLPE/vMy/0DU9sa+0IDVj0xY6z4OXgkTYvMWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8+DLxWIAXq3hiHP9CcegZIv2Gn5AkNJ4UXdqPSPBA3vRRqPzc6mvVwbHToJ8Ok8kW1Cgvmo8OknX1Or9SLOBarXYYxdnUvffatC1hiuH7m++v8WvCaKfSDNwcugyd5r9lJvxVvBp1HeYVVbCw7OJGNe7c7qoQp0wKiFgRzOlk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WmSBu35N; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WmSBu35N"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-151de818519so1406c88.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 20:47:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792122447; cv=none;
        d=google.com; s=arc-20260327;
        b=H3gkPNouLyrCibovIUSCQsKEaMLvMWJjzu+L4Mo+Ozxy2Ou/trz734vJCRFXi6ufGT
         FMaeTTIrIK5Q4oSfSbXJ75NTvyEphL4fNwg2eQKNqxO5xz3VpFfD22ebNoLZDoPNXTtq
         gzVg+B0GgVCAubFGypFHniZozS7EzF/r4w2xnt9maw6xQVMtjpfLwJ4055oKDX2ZMTVb
         r1Q8AlqEGdiTTqEzpxKU/S6HgvdWIOlabo5iOO21GA2DgiUzTdSujHpjlvTZ5gGtgQ0Y
         Sp2w6cmhakUFTtr05IkxnjceUKktoup6cDI7e+JsPvroesa3JNwbzPX+3oeAZMVs1OVZ
         k1GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gh+SJsV9qd4zf8kFfRpYPnxqBTL6SxzjJrawXU6GjJ0=;
        fh=1qiJ3F5uBo3fC5LI1LrOGTcuGDFIRg99y0nYm63EnrE=;
        b=MCDw8oZRtHZkT4+wH9WUoZcyEt6yCNICfPZ5K5lLc0HWu1Fe2N/sC6ff9w+fF/X49b
         f50Hot0+0VedvRZSAwxxTKREQ8QJKuJRm9TS3n1H3qPB+DLjD1TvmMg8j1eeF/nKYdoS
         3lKgjoP+/+zo6AvXc2W8HGo80y0tdZZgDPQDE4+Epsj/0F1iaHvsAdVZwpoa5oaZKpDK
         K0ow4uB46bYA6tb/G50IcDrgBRarnKJ+PooqzA+IYvXQWVewNt9OQCJw4qgIXonl2e+h
         CHAc+cRky492wpRqNi8ph/5ZhVaoEeQwqqgeh/YeBSQfP3KSuoEkNfqp3urbs4tlNsAz
         zfJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792122447; x=1792727247; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gh+SJsV9qd4zf8kFfRpYPnxqBTL6SxzjJrawXU6GjJ0=;
        b=WmSBu35NVeiQu31QNlzjhikocheGgXNjWUJNOfTnocjmaa9dLJL7rjYmck7Yb1z+U+
         7F/BcQN9418cJFFWZhiN289klcAdf7vY8RP6332r/zLY1eDQR3QDdxhuZpxo2G/g7aZa
         v5rtZxY/E5Y21UZmGxBMeG8ox/f0nEfZpgpNvnxMR10va55ZlfCLtmjRq1avhlVq78yu
         FDILCBHBPklvY5onHmwaR6NR/BOznHWKN7qnvyqNIBobtefQODk1/1rS3FsbRoks6qay
         uh6HOUzTvsNyYoVU+csC8enaQ5SbuNJ0SfX1ww1FJ/D0eVCBC9tcI7/RCsBopWWAD692
         YhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792122447; x=1792727247;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gh+SJsV9qd4zf8kFfRpYPnxqBTL6SxzjJrawXU6GjJ0=;
        b=xM8t57Z+xJp+U1UVKarMsXGuyhU2TYa+Mt3dovDlRgcFUIoh8oC8psqYX5KnAMfbfy
         wcaQgthuAjOX8Tx6cAymr3f6Y0q63fV950xGCnMco49RNJyfzfT+uV7S5KMnh7dT8hB3
         Y31LGB5FOVToBqMgPdzW8tDoQRogD5T5mUvJ6JwxsS3WRSAfPGKI+WuzlIOrKWTe61tT
         VneIF9I9yfF0qJEwBoPPD7C4+oFTnQXOomb0zv266ErH9IecfXqRrwQbDwkb7i9MUbkk
         fTIj1lS+beCy2lLA/nsO8o/y56Cds2NYyBrRoifsnzhk4SAbQGwzFwvd9eYw48tHys51
         MulQ==
X-Gm-Message-State: AFq9FYJ1d2D38gqnTVL1TuzDs7aEqNmFmFzHuGccxHV71SpBUv5QPwu9
	ysX5qubwbiuF1TXuR51gzfwIoEKXkVKiwVybm01QS7eT6vks7T5fhzUXIqhYJsU96qgjQCjgISD
	+5zgE7G9FKWw12H+TXpNx8E+0O5bo1rDtUYFEa4Jp
X-Gm-Gg: AYBFou2uuAhikgeOX6tjzRwXZvk7LOxUhrROexRm3d9pAOHWdEKh9s5LwB/cVindNyO
	zighbKBL524gEc9IY/8vnWtI+8IsokmbL58+xsPRnVzPwNb0OHGAd+im7H4aU94fXECajSoe3Fz
	Cb9YtstQndepQhOJtYeQF5VnH8s42dRSmEN3RvL4lvFOwFkFK9a4EkvvFojqNPe4TnlbI11kM5l
	LTlHGp6NtATjISt2mRoGsZBtG/vcSQQg0znMOQNerkRcrL1KW6M9dbqbHGj1SLMM5NJ8uj4+pVc
	yK6WFL7VBnKvZXymmd6vdDZclRWIB7efpVEFcgVIVnEqI1m6o8ZaZQ==
X-Received: by 2002:a05:7022:170c:b0:17f:fbc9:996a with SMTP id
 a92af1059eb24-182bbde9b6amr279955c88.3.1792122446355; Thu, 15 Oct 2026
 20:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014173945.373295-3-almasrymina@google.com> <179209665863.434549.6637198029989888049@kernel.org>
In-Reply-To: <179209665863.434549.6637198029989888049@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 15 Oct 2026 20:47:09 -0700
X-Gm-Features: AclHuK_vtqKDxgWFbxG4BSVZCPmFFjYvhXzuIZSuzOmkSqaPQBtSf8jQ4Wou4a0
Message-ID: <CAHS8izMnj6t5CX3THvGoorPa8krD1RvouXzKQpgZOkUMs8Bzow@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/6] net: skbuff: add napi_pp_get_page() and
 use it in tcp_recvmsg_dmabuf()
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, ayush.sawal@chelsio.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, tariqt@nvidia.com, horms@kernel.org, 
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	ncardwell@google.com, kuniyu@google.com, john.fastabend@gmail.com, 
	sd@queasysnail.net, ebiggers@kernel.org, kees@kernel.org, 
	aleksandr.loktionov@intel.com, petrm@nvidia.com, u.kleine-koenig@baylibre.com, 
	j.raczynski@samsung.com, wang.zhan@smartx.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 1:37=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] The commit message says that "no symmetric helper existed to
>   acquire" a page_pool reference, "forcing callers like=E2=80=A6
>
> --
>
> net: skbuff: add napi_pp_get_page() and use it in tcp_recvmsg_dmabuf()
>
> This commit adds napi_pp_get_page(), which takes a page_pool pp_ref_count
> reference on a netmem if it belongs to a page_pool, as the counterpart to
> napi_pp_put_page(). It also converts tcp_recvmsg_dmabuf() to use it,
> wrapped in WARN_ON_ONCE(), in place of the open-coded atomic_long_inc().
>
> > While napi_pp_put_page() releases a page_pool pp_ref_count reference on
> > a netmem, no symmetric helper existed to acquire one, forcing callers
> > like tcp_recvmsg_dmabuf() to open-code atomic_long_inc() on
> > niov->desc.pp_ref_count.
>
> [Severity: Low]
> Is this description accurate? A helper for this increment already exists
> in include/net/page_pool/helpers.h:
>
> static inline void page_pool_ref_netmem(netmem_ref netmem)
> {
>         atomic_long_inc(netmem_get_pp_ref_count_ref(netmem));
> }
>
> io_uring/zcrx.c already calls it in a similar zero-copy rx handoff:
>
>         page_pool_ref_netmem(net_iov_to_netmem(niov));
>
> Documentation/networking/netmem.rst also names page_pool_ref_netmem() as
> the API for holding a page_pool reference. The new napi_pp_get_page()
> calls it internally too.
>
> Compared with page_pool_ref_netmem(), napi_pp_get_page() adds the
> netmem_compound_head() lookup and a netmem_is_pp() check whose bool
> result tells the caller whether the netmem is page_pool backed. Later
> patches in the series seem to depend on that result, for example in
> skb_netmem_ref(), which falls back to get_netmem() when it is false.
>
> Could the commit message explain the page_pool membership check and
> return value, rather than saying no helper existed? As written, it is
> not clear why tcp_recvmsg_dmabuf() doesn't just call
> page_pool_ref_netmem().
>
>

Commit message is accurate. There is no helper that mirror
napi_pp_put_page(), only a hepler that unconditionally increaments
pp-ref and barfs if you give it a non-pp-page.

I think we're meant to ignore low (and sometimes medium) comments,
unless they're obviously correct?

--=20
Thanks,
Mina
