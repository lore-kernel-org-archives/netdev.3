Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C8425B084
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 04:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788928318; cv=pass; b=eT32Sj7LdaQn1t7T1YO5nTiyWxEqHd0YVTNcKskAS03hUCZrGrNYkSOK3p/zZEbeaHKRgMeNkOohTlj1tvgFPM54YKCLzWDm+be2wJe9HYQxHPSx4g8DX8tR2qHmfCh05ZzSviWBPFqYd2efe98Mx6KQUiqbvDbR/VprzndG4RE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788928318; c=relaxed/simple;
	bh=wCoAPXGQWo/3x8ZcHwjWU9tDfHvxRZZTr1ThfjC8Me4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPhcPENldwH5qf2Kseo/SoL8X8Jkn+YuE766P6ZKu7rrJU329biXn2P42enMC0gOxkdrzp8tQ7Y5wlB07CJRgvFh+LqOFjQRZ9IDrw1F5PwBSKzHU9+V333kcYbUspndLWho4m+pPrILg179a8a0ZaE1R/eG0N+rUX/4uL3Lork=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9qF87zf; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9qF87zf"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc1cb472b76so4149249a12.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 21:31:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788928316; cv=none;
        d=google.com; s=arc-20260327;
        b=pB0Qw/OaRyPDGD6cOwTH9xnTL6nu9Lk/gcRvPF8SlSO/beD5SwfbOQ0RdVTjPtUpMi
         rBgfQ6y+yKS5nHFpfF/OWRLYv5pDlZdw8MiBKqz/Mg4+DKklkk6Mp85yABPzefGHlSL+
         dPqZ1HEK127kT48ME1A3YZxiBl/8QG448lg8ZJ4D70807hJ07iRkRSxMrTxEdJf7E3sB
         htNFQ0e5tFfteJ13pEzpdoiCmj0NrzTVhNp63Q9h3ZMLBRRT2KKWINSSYQFiVccR3ulk
         vemlowJklfgmsjwSMd8ztajON2E2PTzTk8t0LNjzVqUUVuiF+kuwkFCRDUdIpPMUjDiC
         bm1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aalq+Xsboz3fBB7v2n7ALpXM1NAPQRQmE6A5C22OVu4=;
        fh=IwAIJiIiO4yH5YLMYW8OSEzQ5/0RgLvk/6vjA6fw28g=;
        b=QMZtURNPKlBfHI26hpMD56LxEReEnJru2Lee4mAyaMCuDdToQnz0WSvk0NH07CtLI6
         erp5xgusk4FcEtE0HqEbMIhAKOFx93iEg15Gv/BMlW80rJL50ekCgmrferVqJnM4gosz
         Nw4pOxCZdsxflmpbLgUHmmY8LRsjlbqHlA7R1QmbrKC4mKNW5vcTo5j9XtlyKp5m8BDB
         ywrrc2+XL3nP+sFE+vRHWHnGas5GU7qCFly4cBPZ1/ZcgmQF0Y14Ldh1B9mWH4m3uvix
         7WZT4b+h4YEqMoDyPzX4azHLkRcHlO9nbGIR6srU+OMVniUP0BtivtmOqtcmDAfYjT/M
         CAeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788928316; x=1789533116; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aalq+Xsboz3fBB7v2n7ALpXM1NAPQRQmE6A5C22OVu4=;
        b=C9qF87zfzUl5z3O8fzRZT5jjjtl3C+vdBjhhnAf1+EwK0XlSIgfREl0AfZoBo1DmD/
         LGcjR/+g2P75ajvEvj4mmCu6ckvnLcipQZJPNAZw2fIGSEObd3N9lGnpzCslsjdl+Hii
         kL3cPFYqYdivFfkDX1Bp+ve21ebs4Q/CHu+X+liZF/TC5VTm4VkLFImDLqvRdQrk1pXl
         Yq+I5k1RNePdu1ELc4vnFYGD7jAqChb1AY8yCXLcgc2FMTiF4/XKWyMGb4dwugvmyJtF
         yfrLCoY7VZ2nkMuvce70xqSKEpIG3x1HsAe9NbJzFBS1ueL5yNvEQaSSRctbzGu9xZzG
         i6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788928316; x=1789533116;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aalq+Xsboz3fBB7v2n7ALpXM1NAPQRQmE6A5C22OVu4=;
        b=Pb2ThNRkCOwgsVmSfQoFANTztobn472pVkjGTOrrL9j2q3MnfQ7IPjL9QVnU5Ba+hR
         nyQBujjQnAUkQ5ZiFs70eL0z+IafW1n7y5+lZ/rD0U/OjfpWsZitxqen7PgFQx0IFzmV
         pN40yMLZ2UO17UTyNQYql89mJSurpSekXlfL/uJ333ANvH9jhxxMChpfKfY01N30qUdw
         8NjsqGCw1PYz4ly2iW0ai31zq467+6XM3R5rvipxrKZo9zDLMihbjzzu5cMZvIY2eFq1
         CzVWaGFrKtqbyrULKnea312+7rPK9SohZKh02/ol4L75A+BUm6rra49bPWYpnT6sO14C
         MmXw==
X-Forwarded-Encrypted: i=1; AKwUvBzSpWwMKm4ZsXLYnmc0OiNuT+BBjmEfmNCap9KneX7cH5918mVD0iQKLyKNXtdgLdSrsaf2Vbg=@vger.kernel.org
X-Gm-Message-State: AFuF++lq6qKnQyil+wHc2Cby1IRqs+Dw0Ar9Hbtcr7FwXX6Kbb0iPVgy
	DCFvihKqystwxjYleFKF96J//9usmrvHmsPfsZHxbWKEQoFYLaZBZy2lJQ/aLQfXEXYxU36OXdf
	s86ROgeLY0/7/PNggJw72Qge+WhsNV78=
X-Gm-Gg: AYBFou3Yktp09XKoz7VSTL78sW9LITKyFGrqpaxyopqBagH/Fc0RrDRyJ2Ztn5tk/0k
	dOrw6r6d/BU+lwGNrhH6TVgiHP1Ut+GVfUlYlhS1CLPRUy/AKKiv4mjexZ9X+m1UK+0eswknbn+
	4CwjAbMFRHQ6aeJgv6lpk6B5kquDdLdah0i+HS1IszISjsBgXilAXzS6tON6n41u72qDQO1hcl1
	ctQmvSRY9CVjzpBPVlgcZS03SE5Q+U2Y0DMMM9SUuvRhlF3GDVj5fp8DfGzEAldX4FS1gN6J+JM
	jB3tsC7AksjlKdxy8QG4PS8avst9W8EBU5+yDe8zBv2Ia82arvGIRdX5E8QcgJGwHVjTnrFq8ns
	BrLkNhrQGIQngFjGs3KeONYweMrLDIhNwFHl5DDf+piDKZTIpjfLeHTmo+PPgfouzg2Q6dIVk3u
	Qrka3xYA8EoLC7j9TZ93bal3R6qqq1XF0=
X-Received: by 2002:a17:90b:5844:b0:38f:5869:387b with SMTP id
 98e67ed59e1d1-39b26101c20mr49310336a91.9.1788928316092; Tue, 08 Sep 2026
 21:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906030429.2085375-1-xmei5@asu.edu>
In-Reply-To: <20260906030429.2085375-1-xmei5@asu.edu>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Wed, 9 Sep 2026 05:31:44 +0100
X-Gm-Features: AcwNN1Xjri9__-XXqjMy6AxNsRDi7V3Sjo2MFCmVHnIjKnO3ilsgeLwUCFBs4a0
Message-ID: <CAJwJo6asOVa21T==+n7qdso1DBvH6Y3rXo24DdieAQS6XeTutw@mail.gmail.com>
Subject: Re: [PATCH net v2] net/tcp-ao: don't dereference NULL current_key/rnext_key
To: Xiang Mei <xmei5@asu.edu>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Salam Noureddine <noureddine@arista.com>, David Ahern <dsahern@kernel.org>, co+2c72469dbbec34af@bugs.sh, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Xiang,

Thanks for your report and the proposed fix.
I remember I wanted to write tests for re-connect() on the same
socket, but never found time for this, as it's not really used in BGP,
as far as I'm aware.

On Sun, 6 Sept 2026 at 04:04, Xiang Mei <xmei5@asu.edu> wrote:
>
> TCP_AO_DEL_KEY with del_async=1 is accepted in TCP_LISTEN and NULLs
> current_key and rnext_key; tcp_ao_connect_init() clears them on a
> reconnect.  Five readers dereference them without a check.
>
> tcp_ao_time_wait() leaves tp->ao_info pointing at the tcp_ao_info it
> hands the TIME_WAIT socket, and tcp_done() skips inet_csk_destroy_sock()
> on the tcp_fin() FIN_WAIT2 path, so the full socket stays in TCP_CLOSE
> with its fd open, sharing that object.  An unprivileged
> connect(AF_UNSPEC) + listen() then clears rnext_key while the TIME_WAIT
> socket reads it from softirq, and tcp_v4_timewait_ack() dereferences it.
> The segment need not be authenticated: tcp_v4_rcv()'s do_time_wait: path
> skips tcp_inbound_hash().
>
> Check both fields and drop the segment when the key is gone; without one
> no valid signature can be produced.  In tcp_inbound_ao_hash() this must
> be a drop rather than a fallthrough to the keyid lookup, which would let
> the peer pick the verification key that rnext_key pins.
>
> This removes the dereferences only; the two sockets still share one
> mutable tcp_ao_info, leaving snd_sne, lisn and sk_omem_alloc racy.  The
> first Fixes: is where the unchecked read came from, not the sharing.
>
>   Oops: general protection fault, probably for non-canonical address
>     0xdffffc0000000010: 0000 [#1] SMP KASAN NOPTI
>   KASAN: null-ptr-deref in range [0x0000000000000080-0x0000000000000087]
>   RIP: 0010:tcp_v4_rcv (net/ipv4/tcp_ipv4.c:1055 net/ipv4/tcp_ipv4.c:2333)
>   Call Trace:
>    <IRQ>
>    ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207)
>    ip_local_deliver (net/ipv4/ip_input.c:262)
>    ip_rcv (net/ipv4/ip_input.c:612)
>    __netif_receive_skb_one_core (net/core/dev.c:6264)
>    process_backlog (net/core/dev.c:6728)
>    net_rx_action (net/core/dev.c:8007)
>    handle_softirqs (kernel/softirq.c:645)
>    </IRQ>
>   Kernel panic - not syncing: Fatal exception in interrupt
>
> Fixes: decde2586b34 ("net/tcp: Add TCP-AO sign to twsk")
> Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments")
> Cc: stable@vger.kernel.org
> Reported-by: co+2c72469dbbec34af@bugs.sh
> Closes: https://lore.kernel.org/all/YG9s0PiBKJZcXAKld3MToa1IVRJOUoKiaA57%40bugs.sh/
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
> v2: drop the incomplete v1 fix; adding missing checks to avoid null-deref
>
>  net/ipv4/tcp_ao.c   | 6 ++++++
>  net/ipv4/tcp_ipv4.c | 4 ++++
>  net/ipv6/tcp_ipv6.c | 2 ++
>  3 files changed, 12 insertions(+)
>
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index bb7bbc20ba3f..9c2e5c8c8fe3 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -857,6 +857,8 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
>                         return -ENOENT;
>                 *traffic_key = snd_other_key(*key);
>                 rnext_key = READ_ONCE(ao_info->rnext_key);
> +               if (!rnext_key)
> +                       return -ENOENT;

I think this is quite a big hammer to fix the re-connect() issue.
In theory, we could even restrict connect()/listen() after TCP_CLOSE,
but I think I have an idea how to address it "properly".

I have a draft of a patch; I'll test it today and send it for review.

>                 *keyid = rnext_key->rcvid;
>                 *sne = tcp_ao_compute_sne(READ_ONCE(ao_info->snd_sne),
>                                           snd_basis, seq);
> @@ -1026,6 +1028,8 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
>                  * matching the rcvid in the mkt.
>                  */
>                 key = READ_ONCE(info->rnext_key);
> +               if (!key)
> +                       goto key_not_found;
>                 if (key->rcvid != aoh->keyid) {
>                         key = tcp_ao_established_key(sk, info, -1, aoh->keyid);
>                         if (!key)
> @@ -1045,6 +1049,8 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
>                 if (err)
>                         return err;
>                 current_key = READ_ONCE(info->current_key);
> +               if (!current_key)
> +                       return SKB_DROP_REASON_TCP_AOFAILURE;
>                 /* Key rotation: the peer asks us to use new key (RNext) */
>                 if (unlikely(aoh->rnext_keyid != current_key->sndid)) {
>                         trace_tcp_ao_rnext_request(sk, skb, current_key->sndid,
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 9f053eb8b46e..93e073065b1b 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1052,6 +1052,10 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb,
>                 key.traffic_key = snd_other_key(key.ao_key);
>                 key.sne = READ_ONCE(ao_info->snd_sne);
>                 rnext_key = READ_ONCE(ao_info->rnext_key);
> +               if (!rnext_key) {
> +                       inet_twsk_put(tw);
> +                       return;
> +               }
>                 key.rcv_next = rnext_key->rcvid;
>                 key.type = TCP_KEY_AO;
>  #else
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index df9c29eb5c1f..0fb75d139430 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1182,6 +1182,8 @@ static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb,
>                 key.traffic_key = snd_other_key(key.ao_key);
>                 /* rcv_next switches to our rcv_next */
>                 rnext_key = READ_ONCE(ao_info->rnext_key);
> +               if (!rnext_key)
> +                       goto out;
>                 key.rcv_next = rnext_key->rcvid;
>                 key.sne = READ_ONCE(ao_info->snd_sne);
>                 key.type = TCP_KEY_AO;
> --
> 2.43.0
>

Thanks again,
             Dmitry
