Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793959010;
	b=fUUTs6bgHpZSyhcNijfQ2/O8C/LcDWOAzPCjF1fittX+gdzAO4hZ8gik7hUJZt6wRBtI
	 eHWeNOZmHLyaiWhVHCSwrvzD/iSK5JtmAtI58mcx/T3W8use8wBsOdDqbRNVyqEy7gq74
	 smWEILIRp5KkULzg09V1V7VC04EvodNnaR6Zv2LV3DY+rZ6YAMOmLeirQD7UEl1ZWHeHf
	 WKPUZTN47VZIZn4ocL2+RH9nvoxIWfnW6Ud2yCPMaO6GBDI7WpAxVsmOEIDKTycsK+dRq
	 6N2N3nFZsCph5Hh2a5jWrPUsG5tiPHxILy+XKdbJZCKjFXcA2BnHLjpMC3CMZrwyo7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=dXmTy9uwoF9XL/Y4Z/VfoMc9t8DpXi9yTYkuKDHufjU=;
	b=iS1xCAa9ChHBkHvYYNrsBxNKyFBc6N1C4eAGaakNzXuZBl9rV/iNT6APDirU5wQU6v3q
	 xM9ZT5MdhRbN3tbKCvM0XyszA2AQ1F8iPl9Q6Vthuq16H5yq9/0IYADPyCKl5bN8G6+Th
	 Lq/4VhvtpGyrjLESPeRaWMFRqNI8UIOtIrgK6s3Qn2z12W2uGw51dVWlLNHwP+jS6xfcB
	 QegIFW3Qxi/oa3XKMAjB142Nlmx5yq/dKFS3hin1kJ1m/Tc4jGmHP3bzlCCg7NZFLYXWX
	 XjLK1aam8kcui7MP0M+ZGCXLN0sueMxZH36pwpbkV29sQV0pzUtggIQHT1QWGeXXwuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mG007myQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E038606D809
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 09:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E038606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mG007myQ
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6dde81a6820so286568eaf.2
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 01:56:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793959008; cv=none;
        d=google.com; s=arc-20260327;
        b=RQxEJOvCVmyh8633uxBy9sg8QJ5JVzwfmyvYo8+B3zFsotIhGJkNTzqc23j7t49Tvk
         RI2AmLq1zMxQJnilUOMRb8pdjsmM9MUz9/l1iJUj8rLn5h8mZTM9WAOAQEvqqBPGk93S
         oFo0X88sXB2wYXWkd1XN1AMnryK+qD1hOtHWJ0fZSDKv2dEDJYuXcx0BZQnICzDKLKK+
         bFtOSJn5QI/MHpgw9YbCN0umq3BL3AHadsYamPuJyi9SUG+21/g6lwkiI+HVY5u9Q2eZ
         Ca8n+0ga1zvYgMjGxI9BEMYVL7I1syx6yDEGnEvBOWOMsKO4aJc9fQodovWirnW5FArq
         9cUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dXmTy9uwoF9XL/Y4Z/VfoMc9t8DpXi9yTYkuKDHufjU=;
        fh=0qQs0mtzqcbLOW75GQmZlzwQ2inx/b+w5q6rrke06IM=;
        b=Z51mpXteGGyHYO/fMPUDtFb5gSv65b7ggQIjq0Pok11M1QcheJBlXbzKTiJSONjXsS
         X78JzIpnNOE42ikOBsIclfzHj+yb+2X0DcYjt9ByGMz7EvERH7lEkKtM+QRQlIeFxdas
         XV5RAll9EPecnmlQuZatWYnzsyBG2ooylR6a76VUvtSQ9xLeiRUInxib6AareaNiAHQ5
         2eAPrCXaRtXlCJlNXVLS+x7+6Gij82XSEaJUgokoMf98nYq0qy4I0+AZ9qN/5PtSJDKY
         G7jrI00E0lSVfZshUsiPH2Ye1VeVRFbfroFNS459UXnqh46FpK8oIBpk6Gn3vr2gag6q
         KubQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793959008; x=1794563808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dXmTy9uwoF9XL/Y4Z/VfoMc9t8DpXi9yTYkuKDHufjU=;
        b=mG007myQQv8iEXsyxOhdCLnDBMuJ3sEudhIrw7XVImYzlfD82GgX7wDT9wWsOFl7Hu
         7yjF5uIW4+03ikLTTQO/NepbXhH6cxxQ1bDAPVzdH9pBF12xoA07HBfACxMIVODigtyO
         8Pv0r9YXE70Lz0NdKNofcbuJ92qGTCEq6noVO0bmcLYbZvU6M8QCrbS9ssOTdjQTcoGE
         K8Hn5VcSZNVb74u6JG+376HsPL3P2poNRfjlxFZUa+mU/T2zPD1R3Me81fZV1QNvwQns
         ddjWEm7SzLwMRNK6UtM9KROEjUkfoY163j3VoWNaHPJZ2Aji3wFyig81U4NuiDcC2djR
         +Ouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793959008; x=1794563808;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dXmTy9uwoF9XL/Y4Z/VfoMc9t8DpXi9yTYkuKDHufjU=;
        b=aO0eP3AVHHwP3oDOq8P/C6wLcMJJ3J8MJwiTIso4/s89ZA/kJawaELoHtcUi6DbAtd
         4CW3L0aB0f+pvsHFoiE9jDck0Pa77wkxiRAghkXXyzLJYB5JINMoSdQ7hCZfr78+knL7
         pAgeIFJX/qhV63m9MQmm5l6/tLcZbWppz2pctQFKGLgd9b50Pvb3p24IB1eYQZwcYZhZ
         WFnmXeq7Q7W+TJC/RoAYaWU20zRbQ3BToexWhmA/SzKSTFg1B+il+jfKCpw6Yaw12c9m
         tmPJUYJ7T/rl5518yiz8ToP796SQyPzRkpbYf7ezro5yxO4PfBKki8h8nNqhBq1EwkBJ
         Vkww==
X-Gm-Message-State: APuU4Z8wCeYGK5VZKJuADavNdn3YXbdpqKnuvJuXSYWeSJhGy261F79d
	wjDer07GgIbVGlyxSOCB6pJzFE6XMwmNl+o6PSi++zYv7+eiVDFrT2yJQ+WGyTtvbXZVXTjQ7ej
	UL3LpavYwnTSflqHlEvuet2qp7B3byj8=
X-Gm-Gg: AYBFou0qxTOiDga36uRaYk5cGoy49luunF07ouy2eZAR/tYYGc+D6QwfmQcLFtWp54A
	VDQhL3MBo0mKg5ssbf6bNRDhyQAGBRVB3icNbRAwfb3zLxwR/0V7tyJnQta4ntoeIBr43F7uXRK
	bzbUsPHYQaktT7IllneW3Fwy5Z2ovPdaMEKeAkswy/QfuMrPSbztDjL74msJGvlWsEFbpTppHb4
	dnmYZ09EEcyvmoua9dsz8IyMMd2V3vVUDQLH887qe4SgtxCVJOmKQGGWjnjeZOSLpkc9yrcS4LM
	kq6TSTNNNIenK/YeuEvDHTCbgQEcitPMfjsJpeItKzy+Plh/JvMWumIUWVQMCpx2ANhhTc57HKZ
	ivSXGH9i8lmLgdXh+h2EkNW6hKmox4L31pkKun0HUs2HzcRNOJwFqHKL5U6zURIvEbSFD
X-Received: by 2002:a05:6820:1ca9:b0:6df:10cb:4a5f with SMTP id
 006d021491bc7-716e799cefemr1213893eaf.70.1793959008021; Fri, 06 Nov 2026
 01:56:48 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103090651.35399-1-amaan.cheval@gmail.com> <179382654505.488856.2284543045939069308@kernel.org>
In-Reply-To: <179382654505.488856.2284543045939069308@kernel.org>
From: Amaan Cheval <amaan.cheval@gmail.com>
Date: Fri, 6 Nov 2026 15:26:36 +0530
X-Gm-Features: AclHuK8zljRi20SMMxIXqNiJVtR0YM6bZBYEmm6jP7OjzFd7Z5ca0jIffivj4yM
Message-ID: <CAG+wEg1vzCs2EXdLz6vLez_UoyzCzw0GY6=f+CmmNP+xvuXGpQ@mail.gmail.com>
Subject: Re: [PATCH net v3] gve: leave refcount headroom in the RX page bias
To: netdev-bot+sashiko@kernel.org, hramamurthy@google.com
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	bcf@google.com, jordanrhee@google.com, przemyslaw.kitszel@intel.com, 
	pkaligineedi@google.com, maolson@google.com, csully@google.com, 
	willemb@google.com, yangchun@google.com, npl@google.com, 
	awogbemila@google.com, shailend@google.com, nktgrg@google.com, 
	maxyuan@google.com, bpf@vger.kernel.org, john.fastabend@gmail.com, 
	hawk@kernel.org, sdf@fomichev.me, daniel@iogearbox.net, ast@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 2:39=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 1 =C2=B7 High: 0 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Critical] This patch refills the bias only after
>   gve_dec_pagecnt_bias() reaches 0, and it lowers the per-page bias from=
=E2=80=A6
>
> --
>
> gve: leave refcount headroom in the RX page bias
>
> This patch lowers the gve RX page refcount bias from INT_MAX to USHRT_MAX
> and stores it in a u16. This leaves page_count() room for references the
> stack takes with get_page(), such as splice() and tee(). When the bias
> reaches 0, it is refilled with a fixed batch of GVE_PAGECNT_BIAS.
>
> Link: https://github.com/amaanc/kernel-bias
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_utils.c b/drivers/net/=
ethernet/google/gve/gve_utils.c
> > index caed38cd5f2b3..cb6fba3122d5b 100644
> > --- a/drivers/net/ethernet/google/gve/gve_utils.c
> > +++ b/drivers/net/ethernet/google/gve/gve_utils.c
> > @@ -93,15 +93,9 @@ void gve_dec_pagecnt_bias(struct gve_rx_slot_page_in=
fo *page_info)
> >  {
> >       page_info->pagecnt_bias--;
> >       if (page_info->pagecnt_bias =3D=3D 0) {
> > -             int pagecount =3D page_count(page_info->page);
> > -
> > -             /* If we have run out of bias - set it back up to INT_MAX
> > -              * minus the existing refs.
> > -              */
> > -             page_info->pagecnt_bias =3D INT_MAX - pagecount;
> > -
> > -             /* Set pagecount back up to max. */
> > -             page_ref_add(page_info->page, INT_MAX - pagecount);
> > +             /* Out of bias: take another batch of references. */
> > +             page_info->pagecnt_bias =3D GVE_PAGECNT_BIAS;
> > +             page_ref_add(page_info->page, GVE_PAGECNT_BIAS);
> >       }
> >  }
>
> [Severity: Critical]
>
> Can this free a DQO-QPL RX page that is still registered with the device?
>
> Because the refill happens only at 0, the 1 -> 0 transition hands the
> driver's last reference to the consumer. With INT_MAX a page needed about
> 2^31 handoffs to get there. With GVE_PAGECNT_BIAS it happens every 65534
> handoffs.
>
> On DQO-QPL, gve_xdp_done_dqo() redirects the buffer before it touches the
> bias:
>
>         case XDP_REDIRECT:
>                 err =3D xdp_do_redirect(priv->dev, xdp, xprog);
>                 if (unlikely(err))
>                         goto err;
>                 gve_reuse_buffer(rx, buf_state);
>
> gve_reg_xdp_info() registers QPL rings as MEM_TYPE_PAGE_SHARED. If the
> redirect target is an AF_XDP socket in copy mode, the page is released
> synchronously:
>
> xdp_do_redirect()
>   xsk_rcv()
>     xdp_return_buff()
>       __xdp_return()
>         page_frag_free()
>           put_page_testzero()
>           free_frozen_pages()
>
> Suppose the page is at pagecnt_bias =3D=3D 1 and page_count =3D=3D 1. Tha=
t is the
> normal recyclable state once all earlier consumers have released their
> references. The QPL page then goes back to the buddy allocator while it i=
s
> still DMA mapped, registered in the QPL and owned by the buf_state.
>
> After that, gve_reuse_buffer()->gve_dec_pagecnt_bias() calls
> page_ref_add(page, GVE_PAGECNT_BIAS) on the freed page.
> gve_try_recycle_buf() then sees page_count - bias =3D=3D 0 and posts the =
page
> back to the NIC. Could the device then DMA packet data into memory that
> has already been handed to another user?
>
> The v3 notes say XDP on DQO-QPL "will be blocked explicitly in a separate
> patch". In this tree, gve_xdp(), gve_verify_xdp_configuration() and
> gve_set_xdp() do not check queue_format.
>
> gve_set_netdev_xdp_features() sets xdp_features =3D 0 for DQO-QPL, but
> nothing on the attach path enforces it. xp_assign_dev() also falls back t=
o
> copy mode when NETDEV_XDP_ACT_XSK is missing.
>
> That note is below the --- line, so it will not be in the applied commit.
> The patch is also tagged for stable without naming the prerequisite.
>
> The commit message also says:
>
>   Use USHRT_MAX in a u16, as igb, igc, ixgbe, i40e and hns3 do
>
> Those drivers refill at bias =3D=3D 1, so they always keep a reference. F=
or
> example, igb_can_reuse_rx_page() does:
>
>         if (unlikely(pagecnt_bias =3D=3D 1)) {
>                 page_ref_add(page, USHRT_MAX - 1);
>                 rx_buffer->pagecnt_bias =3D USHRT_MAX;
>         }
>
> Would it be safer to refill at 1 here, as v2 did, so the driver never
> gives up its last reference on a QPL page?

The scenario is real, but it is reachable only because XDP can be
attached on DQO-QPL at all, which the driver does not support:
commit d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ
RDA") dropped the queue_format check that used to refuse it, and the
core only checks that ndo_bpf exists. Harshitha indicated on v2 that the
right fix is to block XDP on DQO-QPL rather than to change the refill
point.

Harshitha, I know you mentioned Google would send that patch:

  https://lore.kernel.org/netdev/CAEAWyHfCM_ZesnChP71AQvxjM4MASwukesgzuWCYE=
Cts7jiNhA@mail.gmail.com/

Since this fix depends on it, I'd like to post v4 as a two-patch
series with the DQO-QPL block as 1/2, so that the fix and its
prerequisite reach stable together. If you already have one in
flight, or would rather send your own, please let me know and
I'll drop 1/2 and rebase on yours instead.

pw-bot: cr

>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261103090651.35399-1-amaan.cheval%40gmail.com
