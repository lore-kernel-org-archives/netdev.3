Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793657334;
	b=bSN+eLfS/oAOoGez+93hBh1irMwzP5m7B+AKc6Dc4nVhiz3b5V1UyMZgI2in3cZhldwu
	 eS15MHCX6gedULd0mHmdScGj3b08/b/sOOfNv5/mCb3F6Sn1XCYCaq+k+oCw7PYQ5vCjV
	 w3kSBZcJjAE77R9jQT8Cq7ByX3NW1uEGRuiU2FZMzOMYXovxtaSQqAgxSvdN/cStj5+xD
	 Xrcr1YR2ZJdof1UfTmeeAnA7xuxU3GKp4WhYl+GNFbR20ncZvwa/rf3D53rthXw0oghhp
	 j4+MRw2rwzcAGFIQsWQhqB4L/lJ64osps+KqQGKCfClXd0tPJD6VRnR9oTd7z85Kbag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657334;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=04iaPr/Q4xOZpTpewylydaBAPbXSsxNLl37nHemVSI4=;
	b=V4fZykENvyz5b5Sp273PDHthpfCghMLK1QDPaKfjV8yY79rFVvG7t4Q0wp9WJrB+hMDE
	 UieT0ijPm9+nfwYNUW6Oc2Kjr1mxP/In6u62euOicC34KhsCBA3IYkSQBN/BjSbndCI5d
	 DRhyeIckZYEvG9ZsP4I+OaJzkJQeBXHpPcf0VAPtjKaQ/PpBM1Lp8lRD2cXoiKQDCKsCy
	 nK3gZwjcoudYB0Cy+0kBJ0UUvQMXdvG1fgyp61Eckzi0dS7uSziyJlORFmeXQohrCxIhX
	 PgXMoBU21uB0schFO/4lipOdDypwPaFPN236gh/3Ji4JyaLq7vronMKPu95I9AwlfxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NQVmmG6P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249F0606A337
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 22:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 249F0606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NQVmmG6P
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so3164a12.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 14:08:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793657332; cv=none;
        d=google.com; s=arc-20260327;
        b=K0lSjIOOi+vbF5jphmyLZpMTpzkbe/+ChDbks9pZntYgK1RPJ0AdeHj+oKggXB8TcA
         Z8uMxbS8Hsh7K7gHGyyrJPOlPZasuMegm4wXM3ozldwHe2P+mrlOQrh4XULVy8m0Uv2t
         ZhB6LqqNUsRjYB9yiBE72B4kAVyGxB+7AsiYkbyA7dXx6E6cuSjnXys7xyEEfrOxMNGn
         c0226jWt8yugdt0QB+53vjOkP8/cvOK2rUSnIYj+sUs7CDjPhmmyT8UNWBawKWdrLCkQ
         5FvRnC7nwwIkBjmzVnlLr4B/CK2UuM7Of2TzHrHWCZzdejt0XyJ+VysUBlZaeR842+IF
         qzwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=04iaPr/Q4xOZpTpewylydaBAPbXSsxNLl37nHemVSI4=;
        fh=RTtxDaqV9bWv7Rex2M0l55DmAYcbLshORHTI2wSVkpk=;
        b=cVK56auMbGFegfAssc+4iM4R7a+J5XB0J6uQogmwX3Oh4czVdEKZyuwTLeK806UKp3
         dfNQ0e88wVk3L9vgZfjmkYWi14NtbyBlZ0a4vUd+Dz7koykZ1pTCB60zv47owzpQWU9k
         95NSUiKmEx4CNf6OgIwZXH74qdUTPCVFbPS5aYeJnya2eOsYC4FtcbuWgLlYoznJGW+a
         sLANCcHaFIZ6i+5vHtv9JXQMUM3q7ndH2IFzN9Sz7VzQGsLCrTh7ZVIhITSPD1kZagc3
         RssYhXmFD9XlyAqGWdm3zGU6I15Ws3BTPHsjiZhbzQfXJgp6QlBPSC76VfS+U5dAZWSg
         vM0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793657332; x=1794262132; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=04iaPr/Q4xOZpTpewylydaBAPbXSsxNLl37nHemVSI4=;
        b=NQVmmG6PVNjIV2neyCA9M2St1Rsk5SaTQnqw5Z6BjHpTxwxLNWVY8mIkPbVqVv43Ez
         g1kwACtxFVkWQNTvKZae+D3NXZb1mGV/FYrWMJmL1ujN5VbI0phU2UUIvZ1RySl3e3Zo
         pSWAqChgMM4wStuo1gtjzteMY/kaOtiT6M570xyqph8/dEsROs5zKnwpOJAET9qepMSV
         vCdB69pn/VvgSV+86EtlwKhYvkM3M3xgeJW6A9qGry6TY6rHG0YTPrb0+QZyIpwScHCC
         ZGyoBcYE1XaKnaLT2NSoMPElQaaW3yDHAgebA3x6qLhgrJbVVPEyWmoctHmuVm5Jwrjd
         9rQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793657332; x=1794262132;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=04iaPr/Q4xOZpTpewylydaBAPbXSsxNLl37nHemVSI4=;
        b=uVY02rGuLAWgSUK7tt4/g2VcD1+piFyrw3O83vNA1EJ15FmeAtlraNM++ZpQPjAHCJ
         v3Dmzup3rHtWZz584H9hYOaUvTdaMjtw8pFG6IqzA0JvEr64j32WPwor2Yl2KzqNmhLm
         x+omTDx5xmXdHALgRSZXJtwgD8skxLrs+VKvZGSVMYcw1kIW51Lui6uMNS8xoQH+nbX7
         G7PFvS/aMQtgYFZbhNgyleJU1nmC5wCMshnIIga6tBg8248EQIHOFT1X8SD6wM5CnyAz
         W4WF5/lo+RepGhvoBRz9BkXeSVzjNTNIU56B/Sa941KCigYECyAzE65bXysB1HqgTb2v
         JDIA==
X-Forwarded-Encrypted: i=1; AKwUvBzbYU6Z6DYPGN23D7TkuGiV26r8eEWIhshyuyc1QYiA3TL7XHrrWrxSClpwbbgKpJOoXpYLvvU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+GVf7BP7fKiavk7ztzqwi3EsfBNz2d8YjnSGxyp9oRgadYdJi
	Yr+Zpa8OENhdxzvT/w3J14+KdPFpcNfAjYNcZ6dpvj8keymocP9oFXkDeQ71BuTdbeO/YS21QN0
	u/a09wja0Lu+71fAab4POvF9w8TOkjxn/sjtU2rHt
X-Gm-Gg: AYBFou3lDxLm7kOp7b80zCSoJ2UwhmZGlSwfQLQcLAh8Q+MgTEFtq7sMsFXVdFQGf/N
	sFFHedSgO9kA5ecN1HkrvUYu1703q24IjKl2WXfGqiTk4S4FNH0WkxJJIqP13KowuB838P9COTT
	MsMG5Gz5pZP+ooF9crc4tppP97XnBQUxxoEeCv80UOxV/TpFUZxQFDxRdsPAZbADXATLTpehXaA
	yfExjlU7lku6FpqZlKyrUkPuvtw9KLHpbl22cHEe+1oawyFMzo5LJmoEq2Ok/2LfvlaodwUv9sd
	CEHHfc75gBdNxy1YXAlpy/f/R6Si9Ha7JS6iVFgWibpYd8tTrGYmZoF5RrOWNFpFdKMeQUNzNWT
	9msFlK7dXV582Vp7LBQ/vFXMMc32y/L+FIJasamXUV7upk0Bg7U0oE6sni6GpihTj+vg=
X-Received: by 2002:a05:6402:438d:b0:6b3:f12d:7405 with SMTP id
 4fb4d7f45d1cf-6b53e778d41mr6126a12.14.1793657332128; Mon, 02 Nov 2026
 14:08:52 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030083539.777877-2-almasrymina@google.com>
 <179357408146.3131.2882435952119280563@kernel.org> <CAHS8izMt+5HBjkOOsb-FrwKoXxEBuDn=gf5p+64akYS=SAoQrQ@mail.gmail.com>
 <9afff44d-f8eb-4549-8aae-f99a53339319@redhat.com> <20261102185856.1824792-1-almasrymina@google.com>
 <f4f0fbd6-63e4-42d3-87bf-9f888a8de1a8@redhat.com>
In-Reply-To: <f4f0fbd6-63e4-42d3-87bf-9f888a8de1a8@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 2 Nov 2026 14:08:40 -0800
X-Gm-Features: AclHuK_l2m6u_KEy2pbXoZVvzOwIMj8tI1lJiwLeWg-R9MKJCqxW8rPbMreP4XU
Message-ID: <CAHS8izNQjF6nzPym-kXO2Nr6jv5oKsnFGCNYWZH_zBTGoT98ew@mail.gmail.com>
Subject: Re: [PATCH net v5 1/4] net: devmem: unmap dma_buf synchronously on
 queue uninstall
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, sdf@fomichev.me, 
	kaiyuanz@google.com, kuba@kernel.org, bobbyeshleman@meta.com, 
	asml.silence@gmail.com, dw@davidwei.uk, ap420073@gmail.com, 
	davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, shuah@kernel.org, 
	sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org, 
	andrew+netdev@lunn.ch, sdf.kernel@gmail.com, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, daniel@iogearbox.net, razor@blackwall.org, 
	tariqt@nvidia.com, kaifengw@google.com, dtatulea@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 2:01=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 11/2/26 19:58, Mina Almasry wrote:
> > On Mon, Nov 2, 2026 at 7:29 AM Paolo Abeni <pabeni@redhat.com> wrote:
> >> On 11/2/26 00:16, Mina Almasry wrote:
> >>> On Sun, Nov 1, 2026 at 3:01 PM <netdev-bot+sashiko@kernel.org> wrote:
> >>>>
> >>>> - [High] The dma_dev use-after-free this patch says it fixes can sti=
ll
> >>>>     happen for RX bindings made on a virtual device that leases queu=
es,...
> >>>>
> >>>
> >>> I know about the issues with leased devices. That needs a bit of a
> >>> rework, which I have done locally, and would like to send out as a
> >>> follow up fix.
> >> Will such follow-up rework the code touched by  current patch/series?
> >> how much? I'm under the impression that at least the fix for the issue
> >> reported here would be quite overlapping.
> >>
> >> /P
> >
> > I pushed the follow-up branch on top of v5 here so you can see the exac=
t diff:
> > https://github.com/mina/linux/compare/devmem-teardown-v4...devmem-lease=
-bind-map-dev
> > (commits: https://github.com/mina/linux/commits/devmem-lease-bind-map-d=
ev)
> >
> > There is some overlap (~55 lines of v5 touched across a 6-patch +262/-9=
9
> > follow-up): it renames binding->dev/vdev to binding->map_dev/bind_dev, =
passes
> > the net_device explicitly to net_devmem_lock_dev(), factors out
> > net_devmem_close_rxqs(), and replaces the !rxq->lease / !netif_is_queue=
_leasee()
> > skips in net_devmem_dev_unregister() and mp_dmabuf_devmem_uninstall().
> >
> > I kept it separate only to keep this net fix smaller and easier to revi=
ew,
> > since the lease issue is pre-existing. Happy to either land v5 first an=
d send
> > those 6 patches right after, or fold them into a v6 if you prefer avoid=
ing the
> > churn.
> I hoped for something smaller :)
>
> I definitely would not fold the 2 series.
>
> I'm wondering if this could be considered net-next material? pointing to
> net-next will offer better guarantees for all the work to land in the sam=
e
> release (no need to repost in such a case, I can apply this one to net-ne=
xt
> directly).
>

I'm more than happy with net-next. Honestly so many AI-foudn fixes
requiring so many refactors that net-next makes sense most of the time
now, for me at least. Thank you Paolo!

--=20
Thanks,
Mina
