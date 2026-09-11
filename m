Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF57F2EEE67
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 02:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789094372; cv=pass; b=QYRFYDNWyu60I8Ms4veq57wox6n6In9XEcXE2h1yAVVKn5UKNSPXa2iLq7hUk221oOCRmnVJ4ByktM81E4+fY0Aj0VsL9g6R5h+kmKRzwpcFDqvk7qHCXpNfrhx6VCyOe8YCV2hAIo+qjbxw9mYMMxDR73rhI8BnqNYbCIbAzBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789094372; c=relaxed/simple;
	bh=OfSgPMHyPcfe9C+HEDHdSPecHBgxUdzMeajgKpSpE5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHqvrHEbZ1J/4MQHWs8g+7cK9F/8H+ICkwCLjkDQot5dfrvOCIVLVxyWw5mlQ3UN1uldw2M63/j10lF0imrMvaoyh/EgG98t6Wg0nueZYIT0IA4v0LTYHgMSVm2QVdhByxY1lAvUNX6xC5QJB7sV9PQVMgfQf6WHJYfwUEjGk3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V0hObskk; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V0hObskk"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb769ca02so7267301cf.0
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 19:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789094369; cv=none;
        d=google.com; s=arc-20260327;
        b=LuT8qG2j6gQPYSMtpfN/38jWD/GPy6vs9PDYkC2hBbjjG1Ujvp/cgo66tZP5gtSUg4
         LeI49pbo0U1sicJPFSXTjNvzbcEisz+B3rVu8c6UhvHAoJp5TQPxVxSACU9AxgE3IPVd
         pVyHTTNDoyp5vNFhUhlwa/D3Nn7BaiCQjVW2T20+mqmETWweyjZjsuBYofTQFdAg2iJT
         DOSOXvkP0FCf+x6niskMwwNzolDmwoh+L5TlYWkIF8sEQBY4jsTx4sZleb89/6s8WZbe
         rWt0q/qKMomp78M2ASaUqgn79Lhs2a+xV7nXsbCS6S+BmWxc8gXDp2ubWfMRIdlofy/j
         DTLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RUDfrm8jdk65W+DYIk8XE8Q/Uaw6XoTn7o68Z+TcLK0=;
        fh=jMegTJyz/tAFaZnCbEGVybux7P8SRtklsjVazRuCZFg=;
        b=oDDZhoASqM96lqbNM/3yvXr1niYPbuKp5SsL9ezQzG0vjdy9Quh6kngIrEAjAeT/67
         mrAOoSVifAKqcKllyI7cRIcWoiBRxMQEgOFpAIA6CffyPzJ9pIO8wR+nr1a3qCDqXl5a
         u+r+Sb0lrYnuWPblHTYSoFUWZ+O5kJE41eGIVOCNRxPdpu7KfQR996x0S9XE95XXzmF1
         ICWBzQ5Y0OIZCBftXd16ZlEaByckKZQIrs3jk2N3nMRUmZHqMeSuPKc79XfGpHmr32IT
         eushwiB8ORa2jMekmCv68Zi10UyzncgI6DsLLcb1MBLk8XZZReIqBxMqUHlhqRtwR/KQ
         eIeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789094369; x=1789699169; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RUDfrm8jdk65W+DYIk8XE8Q/Uaw6XoTn7o68Z+TcLK0=;
        b=V0hObskklRoe1gJC7Ou0HBuy1q80Deu+NPnVPREwquRINo7TRlt7DYg1NO08A8/eAA
         yICeYYSd0CtILV8rsB165pShoA7uugpiiGYsYDpNDty/wZoz0/NBU9gw8jUIK5TgEeSD
         2PAJ29TeN41aMR18b2CHjXKCopgWUUMMQK4+4KbvZ2yh2kKSrWQYufpfaknsFoZyb5ZF
         WynITAR/iXmSY7g75wQsT62n19Tp97zp90nVkmyM27b0m0pPl6mzBjpxf9mw0GrEUwOB
         dKR+FqYA6yph69VKshIqn9X841NSr9+ni1VbUe48GAqADs49aZ0iO+3i9tDA9Ktlppol
         EPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789094369; x=1789699169;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RUDfrm8jdk65W+DYIk8XE8Q/Uaw6XoTn7o68Z+TcLK0=;
        b=prcwgTldth+X9cBgOMNjy+5hqvUjjLV7NL8iVidrBAe+pQTgaraTeqyQ2IV4p3iVdo
         NfZOwDvvbM9pl78cCx5OIbpOHBD+MXjRbB5MKZBKc63C6nX8v5owLj6Ew3MnuwrG88NP
         j1fJHLoAqNUdGOg/Ta2IWi6y9ZtgUSXpgkLHPnzXF5IPte16xsOL46t7uSqSqTvMT1wc
         kOizqyYTRc21jSZRG4Q8UltJX84tVwkuOG+TzXTTw2Nj/K90y0PlnZoaFGPOypgYe5hm
         2xb+73ZYgCuXNEtUQrR+tyq1kVdTrc60BSIhahmXsHmqXrq30S7ddmGiZ0kAWjYGJOnr
         04YA==
X-Forwarded-Encrypted: i=1; AKwUvBzGoowWqQAH81Z11sDX4jHFNfT+ibvIJL1jiwygevrQ+opa8xb0454vTx71mQz9aIGKZFEwYOc=@vger.kernel.org
X-Gm-Message-State: AFuF++kkA/78KvwmJZTClSSj3eRLaEyQU4MTwB5HUR3Rk7RzBugvKZlz
	A10LGdnDg880ztS2cTDu+VhYGQRY3Y7KapUw2ygyxBwVixewINyKv+gJbnBNu9sZ/0lh4BTcsHA
	6yPhuicUNPJrRLf7cKpQujCxiTXzAV30LCVh9rf5y
X-Gm-Gg: AYBFou2LZkHWkIM4Tl7yYhMAayhwrOhpsb608IlxDT3qdySf2AqKLBx0dHIkNMEWu6w
	p9yz9rTtgPne7lYG4/su/p+wL7fcAgoPt/jKjig+1ho/fgS/O6Q0IiT2/NwZXTwYB56BvtbcJv/
	pYExncalZl3+zsDoRkckZqxCPl9MjgT4S3X8EHyQdj0XZipvKtkpMCEI3r7gLir2ZRNcmi4Qrir
	zj4AVf0tO0AvvG1dbI+VPeoobZeZOi10FMAKV79/W67iFSqDG1huQCfn+Kh5yNcstrbUkkxVbwx
	bdDE/WzInuwudND+cBspNjwGrLLLEUecWt6DoNcGFP9MzVxM912z+qVkNDO4mMtdfLVimyFDDNW
	NoPRvK3EqsVpwKdHq7lZXwN+F25rZvk3tBQnv36csc/FnTd8Bp4Owhq5EVNxc2Ziz4tgwli62XK
	7T+hpU3Wzr5MBVbJWWK0TLOSxXWyv9rbw=
X-Received: by 2002:ac8:6104:0:b0:52d:8743:bc83 with SMTP id
 d75a77b69052e-530c86d5bcbmr52047871cf.34.1789094368979; Thu, 10 Sep 2026
 19:39:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911020438.3502801-1-kris.pan@intel.com>
In-Reply-To: <20260911020438.3502801-1-kris.pan@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Sep 2026 19:39:16 -0700
X-Gm-Features: AcwNN1UmG-09lqNpFifG9eMrL0aAKirFhylmMFlnO8B_rmhq4zvEOVMQ2vDehcc
Message-ID: <CANn89iLpbdkmA0QKLXcV5LdzCsDjgJEUXb5-2eqWJTveNG-uJg@mail.gmail.com>
Subject: Re: [PATCH] net: iterate online nodes in skb_defer_free_flush()
To: Kris Pan <kris.pan@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	atomasov@redhat.com, oliver.sang@intel.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 7:07=E2=80=AFPM Kris Pan <kris.pan@intel.com> wrote=
:
>
> skb_attempt_defer_free() only queues skbs on the current CPU's node
> (numa_node_id() of a running CPU), which is always online, so the
> flush loop never needs to visit nodes that are merely possible.
>
> for_each_node() walks node_possible_map.  On machines where the
> possible map is much larger than the online map -- e.g. a POWER10
> LPAR with 32 possible but 1 online node -- the flush loop touches 31
> cold, always-empty per-node lists on every softirq pass, showing up
> as skb_defer_free_flush() and _find_next_bit() overhead.
>
> Use for_each_online_node() to iterate only node_online_map.
>
> Loopback UDP throughput in a QEMU guest with 32 possible / 1 online
> nodes (bench_udp, 8 senders, 6 interleaved runs) improves by ~5%.
>
> Fixes: 5628f3fe3b16 ("net: add NUMA awareness to skb_attempt_defer_free()=
")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202512112119.5b9829a-lkp@intel.com
> Signed-off-by: Kris Pan <kris.pan@intel.com>
> ---
>  net/core/dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 290e0f099e6bf..b528b6a986fcf 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6907,7 +6907,7 @@ static void skb_defer_free_flush(void)
>         struct skb_defer_node *sdn;
>         int node;
>
> -       for_each_node(node) {
> +       for_each_online_node(node) {

SGTM, but you probably could have added

Suggested-by: Adrian Tomasov <atomasov@redhat.com>

(Assuming you read
https://lore.kernel.org/oe-lkp/20260910143041.18106-1-atomasov@redhat.com/)

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
