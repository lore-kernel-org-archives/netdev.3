Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAB437204C
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 21:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493630; cv=pass; b=IPJSxgUURY1GuUiNXmGNLLPjV5l6dbi4vuGK+06T6A3fys5fqc4ASuJHEFLzef3ysZxK5TU7mQIkc5TQiIhO+o/0N9OOpQXe1gQK9RDLP3uaJNdrTOG7K6yzWgBge4J2V/LQr5y+IteIuZs4E4O1lKld70i9u7m0rFyfV0SBq6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493630; c=relaxed/simple;
	bh=4nz3nYHHX3Reki4JfW1hPIjRnphQt1b3FM5D6Y675n4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYsyijBsoR/BleqUgro286uxivbTDLueSHxVXritaIYzMPC+HFAQ2qHPvRaMIUiESqodSWL7Rw2plVxm8LCTqQZA6O3zwwW4/mFYGZ/r+jAXV+EvnsaqOPQ8C3HtAxDVkcIrcWj1JZrvW21eou4OGli4tSIeyyAJB9gnTclYiYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXF6Ojkb; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXF6Ojkb"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-677c9e8ddb2so5718684d50.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 14:07:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791493628; cv=none;
        d=google.com; s=arc-20260327;
        b=I0ytT04QT0RDjnP68wiSK8quIoMdrUlUBGBt+fbc7MYlVemRQ4mOf/mHtcnGE+0Mn/
         egYamwLR+IPjW6S+Gk0LshbunasrBqoBYGm4blgmBbCYiiZkKXiLCums9tJvZ6ITcE37
         7X8WDZoXpc+1b3Hjup8P6x2CSglL9N2FG6RNo0N6eB4klFxbaJQQVXOUhXYu2hYl4BZR
         INaEOuZLrvu42SgQyOm/FsyAWGBBkk4Jib04u+FTFpaO70KVgxqfBRslXNc0buLVMDdo
         PVklxtFfGoPICZRcpEuex/kTBj7LY7NeztU3xWPEkrBLbupqcjCiDxxcz95/1qViE9e9
         JQkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jii9/r18Olxdr1eS+4Fu96DI9P+T46OmwOu67YnP9mo=;
        fh=3dZe0IadG1ALImD1I+UW6mdb+hfcmHfInr+xB5GjAsY=;
        b=IWUOL9twazphTXZFd3LfGWogdbzCAkgDtSXHuhmon5C3DCra7a68a15HkmQs6rEssK
         yxzgWJRpC8ZRm7e/SoG/Hmao4keUijfI/Y6BKH+sWXJRU+LABOG8/qMGDNVuzIKPiqtc
         fFVN2XVCBgaCtX7ux1aknmex7NwU1E709k1i9/r1NN4U07KuAEv9zwl4m4g9U8Ex9Twi
         SdFduAXHmy0WGXodLnlelyp8cmxcfdBdXv5kldaQJfTNyHTexYI0b6JECT5Sh5kz6rWR
         4wPwfZSfCeRlmzzyfcGrke5wbpweYisvFHU6sLWdXtV18xlIb21lmWmMyNq56NoMzJVS
         JlGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791493628; x=1792098428; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jii9/r18Olxdr1eS+4Fu96DI9P+T46OmwOu67YnP9mo=;
        b=NXF6OjkbQeKN7PR2fHZAzxzSPjGpHVsPOFnElAY4sJUn901xfZyopWJKZgVP81JfhH
         RZoFnaCFxZQzEmN9dM/yrVclTPkO90P2oLYmjP71RGj4rELFFEX2NiZe5LAYRGfoTk5i
         AM2oc6/1hhm3/RLlm3bsCkKsLzbyn4R8EzEZyDmswpm85+eGkm03AMkr/Sn6v3kVQ8f2
         Cjoj6cdbixoH8B9rJ3s51OP5MKJPg5Rsr1/3bkKHtXnrdHRiUGL3opnLX5TZ7FM1qacz
         FzMF2NadIZdVY3pULJOxx1TePQHcHbAPYARLXTI08cKdMi/mfZIRISDoN0bB2gY3PCch
         Ij8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791493628; x=1792098428;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jii9/r18Olxdr1eS+4Fu96DI9P+T46OmwOu67YnP9mo=;
        b=j58/t1kIJCTLdoEb1zcxX5z+XhnBOibCZnewfTDXCPS0l2tcQx98R+S3TT1avyDj/9
         DRkU7PPAkqbLq8i4uJmGAbFl3s1XQ0qZQh301qUP9zzp9ZYAOAyE86Q88uxIV1npa7yr
         RTPPmEcEqmLsP/SKVW5zvxxedpSjjp91fq5/J2NwzZ5F6bksv8uesjuEyX4WnYfHdv83
         8zlTk4WStB/wU5aDyh5hELAtB/SiqU3mN3kXHnCMQLX5o62PlkZlDYznjGCO+Czc33VH
         qS7G9xa38XOpx20wFmhli5uV36ujRiT/AbCLE+XF2HZ9Km/P5HfcMmU5GtyMg7rNyZg5
         pZSg==
X-Forwarded-Encrypted: i=1; AKwUvBypshFUpV38+HOrNs0S9c8GZ4g0NR0R+99s8sEShzFx504VuQm/1XnsJljZQijHxgWOzboOf8I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJx6ZzX3opjfL+iri5Kb4R8wtv7SHH6zM04VcSCxoyzlGYckvBr
	3NFEOszWO1pEo5XIq21DTiZ2hgF+9JSs/4uay42TrJZ8b4Z32nbOn9LCYRseG0bPM8HUcRZDn/e
	gNf+Jy7rFIn+id/Z8/MrUQKo0U/HMnfU=
X-Gm-Gg: AYBFou2U8QmXqsIrfd/kN8VHZkUSKXTXxZ5+oBOKHo9J7gYH0Hrq7rewe8fgAIRvP+K
	mEBL6mJ1BNQoXm/1NLgCTTJbRwT6eYlpLoBt+eelXWU3FDEUhz5l2ADPLNZkHADGuf83eIXSLF3
	9wcHW1GpEvKSaTcqVTDRMKgvaGxTVcLIyrbSqYR/wX3fV1Dc5orOJPk3NrZob1WtV5DYoYR/s1u
	mcxFVL4pr/YUvBIkXj0HXZIGTfuUgnL+vF7aoJRM7rPd7I8L2aYf7K0QJ/laBtukqVKE443IYr1
	t/F1+lQIrFIec+u3XpfAtdN1wbDEF3CoNkqZiAjFp9YpSEoPdY/T3PyhlG5+2MBCcVFRxg/nRd0
	YGMsqgOW0yriqTReci3EdjtOHA4JS0siTf0noh/epyw==
X-Received: by 2002:a05:690e:14cd:b0:676:933f:736a with SMTP id
 956f58d0204a3-679362ffb23mr31652d50.81.1791493628413; Thu, 08 Oct 2026
 14:07:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007163819.3041710-1-willemdebruijn.kernel@gmail.com>
 <179148831819.434549.14553358529954439471@kernel.org> <willemdebruijn.kernel.18efe47d2170f@gmail.com>
 <20261008165313-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261008165313-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 8 Oct 2026 17:06:30 -0400
X-Gm-Features: AclHuK8vhdhXQFBiw3VMfd_LshePS5Pnx5--cfpNYS9ZITkOPztJTB-tsYKpfiw
Message-ID: <CAF=yD-+S83OzhObTKBKvqGayBCzCEeOpF5pO4b7=oFF-mxgwcg@mail.gmail.com>
Subject: Re: [PATCH net] net: extend virtio_net_hdr csum_start checks to VLAN,
 IPv6 and IP options
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, jasowangio@gmail.com, willemb@google.com, 
	habte.yibelo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 4:55=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Thu, Oct 08, 2026 at 04:04:16PM -0400, Willem de Bruijn wrote:
> > netdev-bot+sashiko@ wrote:
> > > Thank you for your contribution! Sashiko AI review found 3 potential
> > > issue(s) to consider.
> > >
> > > Critical: 0 =C2=B7 High: 2 =C2=B7 Medium: 1 =C2=B7 Low: 0 (1)
> > >
> > > If you believe none of the issues are legitimate, please reply to eac=
h
> > > issue of Medium severity or higher and explain why the AI is wrong.
> > > If any of them are legitimate and you plan to respin, please let patc=
hwork
> > > know by including "pw-bot: cr" as a separate line at the end of your =
reply
> > > (one such reply per series is enough).
> > >
> > > - [High] The fix leaves the UDP-tunnel path, virtio_net_hdr_tnl_to_sk=
b()
> > >   in include/linux/virtio_net.h, with the same weakness it removes fr=
om=E2=80=A6
> > > - [High] virtio_net_hdr_thoff_valid() decides whether skb->data start=
s
> > >   with an Ethernet header only from `skb->dev->type =3D=3D ARPHRD_ETH=
ER`=E2=80=A6
> > > - [Medium] On the non-ARPHRD_ETHER branch, virtio_net_hdr_thoff_valid=
()
> > >   leaves proto =3D 0 and then guesses the L3 protocol from the versio=
n=E2=80=A6
> >
> > All comments look valid and require a respin. Any revision will take
> > them into account.
> >
> > Based also on the previous conversation in this thread, will review the
> > approach. Updated in patchwork to changes requested.
>
>
> But let's agree who works on this, please. Have a bunch of stuff on my
> plate so if it is you, I'm very happy and will just criticise :)

Do you agree with my suggested revision that just drops the checksum
offload request for weird packets?

Or do you want to investigate your suggestion to skb_checksum_help those he=
re?

I can't estimate yet how easy/hard that will prove to be. Can
prototype, but no guarantee that it's a fruitful approach.

The next few days I'll be OOO, so next week at the earliest.

We agree that this is not urgent, correct. So can do some prototyping.
