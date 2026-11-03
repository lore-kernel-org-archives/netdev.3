Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793723318;
	b=0kmjZDA9UY3eFe3bndnvddspyejXAZNkjAAQVobtJDPbfZLvfuw8Oq1mJKNKwkrwGrg7
	 NT+YQxTkJKJPKVWe114Fq68h5SsUQ2MdNSEFIaiS0fnbRjQLwA1jPDH2v3LsQeCUEtvWG
	 J1iEnfpDRgkESkORnqHd34D3DpClCTBMHkLCIUVE7K+XRwN5B27NtAOJ7+3tcXJKgXkEc
	 jM+YL65YSmbYX8uKVBMDix2J8VaDLeBny421rgZBvJ2/fIGVCirsfLexiT5JDMcjfaV30
	 FnEnwLAXiD1ucnFWRAXUXFtYPn9Nb83oIap3V+coVQFXqLphTbMTYxbH4SGSZjg2c0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=iNrqawb7znOhdynzk3QZawC3lApb5SKPQ8U0JnSF1mQ=;
	b=EGFgefp4imn3IdoFUyDjB9bSrpAcPgmsCdp6tvy34kWKlP+sa18f9c9Ss+wXYWMIgY/O
	 8jXXoAweYKaGVlE7+g12OXbaa+QXZ7izbj62VVfzNX19dywLDTYtpYJdF9RY5pv18NBGX
	 4llp6//HT3Fh1QAd1YN5AMRBB+m8l4kAKiDl8stoA/hXDRI18YLbf8obcb5kqV1y/XnyP
	 r0FlQIhPuUPnJIEXwF9CYRoIFCGQk+p1rhE+CtBXpjv/Nc4093z3ksm6rRUSBPNLaeMJc
	 jq7Rg8epIEbKEMBoJ3wwR6ILD/WqxXsGuyPC1zFigX3/Du6aNy+sP2fCPSz8yYBnWbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LqpwUQxF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FB3606A327
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 16:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3FB3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LqpwUQxF
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48fbe12cfdcso43702f8f.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:28:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793723315; cv=none;
        d=google.com; s=arc-20260327;
        b=jMWnqycfqVBCVbtVDHnxZxewJj0itrhcbtkn0X4f3dXXcwunw31bh14/J60pyWxYAO
         MwVMhZyVfSVvizyoJWtRfq5B3G8OCKT59yBWNetn7VE3gMXNU9qjEXn42yoPfAObjaN3
         mU9TvJX7gxuRnze+yzXdJvxePhyBGF3Yljbwd18fFLgjZ2Yrm0/iEuGGomPgFvIptIT1
         vJmWoUw5G2yRXe44NlFDoZq9/E8an83bFf00I5EyuIvXVI88CEYvdB5wnvA0doKXsyHX
         Dih/f2fbv5Ae3FgqwGjpFxoHDUhEiBmsARVbh+Q6lKFAd5a69PAB+p+ctFPUOSho0CVj
         weTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iNrqawb7znOhdynzk3QZawC3lApb5SKPQ8U0JnSF1mQ=;
        fh=hbdWQJaqK5IfMTolQTDtDsrJCeBjg+BTw9tr9WS7Q5U=;
        b=WKNEnUy22R0zJisQnalmZGyTX9VX8YOXrAEAaA45V5uEieKgysSec6pnNILEGaJjWi
         w3EcMLdqD/BP8G1aIeBfwtvMIQu354BOdJuB7YvjHKrm1xeih0kbLZaPagU/rugD1h5n
         i+jr+T+5RAWopJzViuHkdkKbZSBUcYjoal1KcQvcDMzJ2YWHVC36sWivcBTO9L4JaUJ6
         PiyUbB1ATnd83zlSSeJO8GMeKyu6CKA68KOVLVYvMQf+L/k+uigzGLWuUAgOBS233MKW
         FEgZ/A4F9bpq4ZIy2G849rDrmSD5iL78TKrxIMwpZ83gQZJZAplAusmH0EwETZlz1Ljl
         FfTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793723315; x=1794328115; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iNrqawb7znOhdynzk3QZawC3lApb5SKPQ8U0JnSF1mQ=;
        b=LqpwUQxFHDyhjKx+++qQ03EB7zP6QXkk5NIIeDdLl+2BNMqteUQ/BWFxI9lcztDTm0
         /Lo1jxw0teouU0/A04ww78TjzqMPuQM2FQ1htRceS/qD4hsmfrZ8XCPwLBNyaDpLc3B2
         UldbClo8y18tzgFBFsSRVURm2/MVnMErmIm+qfXVrJ/7HlDqaoEuR1UrRlRL6cVtvV3E
         95ZwKPQoCtgNGI9IFP7pefJvUAQ1zbHFAMojdSFCvm6rVP73xQ0BvyJ4NPjG7iqvkERH
         yYv75Yy2K5QLvumlMv8i4M0QBCPhQZ8EbzSAk/zz7gzwYTEnyqobj5+tb7vK4k1onxtm
         zRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723315; x=1794328115;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iNrqawb7znOhdynzk3QZawC3lApb5SKPQ8U0JnSF1mQ=;
        b=csoFtmUvL0cXPHPxl6LbmrKvCiYfhVC2/JgFNqpUko4wHELSv0NlqFG+ze/N7+V6IU
         a9o6X1PT+1e0vbsNQGSnHDu7fv8+FIxOsx2QtAygIdIAFz/bvYmlYl5GHMk1Lw5b4fdt
         Mp9HZGQ3cWKTLY+GNE8C+Z34JY/u/Et9BxuZDhnA1s09HMw9HsDMZ3uP32qF/ZGgbiMG
         a47TIpE/DxKv7mgR4qhgNc5n5LhW80j51sPeLSGq+VwVrEN//OsYIhVl1eydOpBL6Roy
         NYQvTaDZrgfOczFpSSU3RzL9eRM63beDUFb2dy5fobTDV9UxFu6ShOYsH/WmBi2RiHbw
         Tt2A==
X-Forwarded-Encrypted: i=1; AKwUvBxLquGP2bkzgCxh6TfZbLeVXYHFNZxFC6heV4b6BbADV/VmRpKuRKyaiyPX+bMSoBTR28Rx1R0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NdQl294rFVSe6LS84gU0/2A4OX5tfK53zFz5PQfEI9I+BXnzm
	k8JAgp5Iwzkbd8bPKiD2Nn3mA4cyggHx360qlosMslBIe8/NlsVil806tlQ6gs8MtLYO+qt+7Bo
	iqXXr+X3OVPLB5sRwsox2CcNm5dXJTTU=
X-Gm-Gg: AYBFou1igp6xX52ROUGyow2s7QDvnIp2yn/RXhWAH1EL8NkS9g6QKU2IIIdm14Hceba
	UdsXRhLFy9IFBq38GnSR/HQTTJ8tGe/Y28ytMNbtZmqg3PsbWeh4nEknOjzsnfLQ4kZw6kccEEn
	yyKljqn8CxjO9pQCpMDjun9fDnhVXWXg5dbD0krexayaB5QQC05Irlza2hsDNe1p0pwHyWL0FVM
	r8XX0onelogz7q8cM6VcQbjECcYCU6pD54sznlYrcU1ML0i8WOqFTBffo7/ggvjwLYgUaaE8wn0
	F/5z307HE/+mnuMuSXuFnp2iKgsu8hiQrTbr/kn0tHcHTuTE7Co43IzmTmBvHNFhKBvo0VQcSCO
	s4xee5l98pnc7rCzAiqv0FicsL2Jr5jlAIO8yzMuujhhirgpEheN8CTad8xWytxOmKJ5XBpvFY+
	Xr1gpvAYdP4Ma48KddY+7Pux7iBlQc0YNDhYiIPa+2667iSmWuJHDvhw==
X-Received: by 2002:a05:6000:2404:b0:48c:7386:af18 with SMTP id
 ffacd0b85a97d-48e6e2c1e2amr29659218f8f.8.1793723314831; Tue, 03 Nov 2026
 08:28:34 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028170239.28606-1-tactii@gmail.com> <31444b89635e8520c262ae915235991c3c075a0a.camel@gmail.com>
 <8df82d18-da9e-4077-8ed4-316e5314882a@gmail.com> <CAKgT0UfcR12X-+O5XvzqCV4Hh5rHs5dPZSps5t=1rPC5SU88eQ@mail.gmail.com>
 <bf1f9ee0-c7ec-4e6b-bf22-14e64413118d@gmail.com>
In-Reply-To: <bf1f9ee0-c7ec-4e6b-bf22-14e64413118d@gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 3 Nov 2026 08:27:58 -0800
X-Gm-Features: AclHuK-P7m9VOIbcOGQMmiHqx-bxMRQC6xGVDdY-66Tx-Pag-hb_2xV8nBD-_BU
Message-ID: <CAKgT0UfTMsJok7ZOBukzrVKvTC9qV38jdfWH6yKDEPJSEsB3CQ@mail.gmail.com>
Subject: Re: [PATCH iwl-net v2] e1000e: fix Tx descriptor field wrapping
To: Matt Vollrath <tactii@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andre Brait <andrebrait@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 8:32=E2=80=AFPM Matt Vollrath <tactii@gmail.com> wro=
te:
>
> On 10/31/26 12:53, Alexander Duyck wrote:
> > On Fri, Oct 30, 2026 at 12:00=E2=80=AFPM Matt Vollrath <tactii@gmail.co=
m> wrote:
> >>
> >> On 10/29/26 12:47, Alexander H Duyck wrote:
> >>> On Wed, 2026-10-28 at 13:02 -0400, Matt Vollrath wrote:
> >>>> When an skb arrives at the driver and the header length exceeds the =
u8
> >>>> hdr_len, tucss and tucso fields in e1000_context_desc, wrapped value=
s
> >>>> are sent to the card. If TSO is enabled, some header lengths will ca=
use
> >>>> the card to hang.
> >>>>
> >>>> This was reproduced on an I218-V with an unprivileged Python script.
> >>>
> >>> Can you elaborate on what the script did to trigger this? I am
> >>> wondering if it can even get there with a valid frame supported by th=
e
> >>> interface since most of these e1000e parts don't support tunnels and
> >>> such.
> >>
> >> I will send you the script OOB. To be clear, this is a security fix,
> >> not a correctness fix for rarely used paths. The rules say I have to
> >> post the fix publicly because an LLM found it in a
> >> function-by-function scan.
> >
> > I got the script, will try to take a look at it over this weekend.
> >
> >>> Also did it have separate cases for the CSUM vs the GSO? I would
> >>> suspect this is more a CSUM issue than a GSO issue.
> >>
> >> I have only reproduced hardware hang when TSO is enabled on the nic.
> >> Otherwise it likely just mangles the packet, but I have not confirmed
> >> that.
> >>
> >>>> Fix it by disabling GSO and checksum offload when the header length =
(and
> >>>> checksum offset) would exceed the field widths. Compensate for a
> >>>> software-inserted VLAN tag.
> >>>>
> >>>> Because of a quirk in the ordering of ndo_features_check, the skb's
> >>>> transport_header field may be stale. If the skb carries
> >>>> CHECKSUM_PARTIAL, use csum_start to find the header. Otherwise, ther=
e's
> >>>> no reliable interface, so don't offload it.
> >>>>
> >>>> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (curren=
tly for ICH9 devices only)")
> >>>
> >>> I am pretty sure this Fixes tag is bogus. This is the introduction of
> >>> the e1000e driver which was in 2007. The ndo_features_check didn't
> >>> exist until 2014 sometime after that if I am not mistaken.
> >>
> >> My understanding is the Fixes tag should point at the commit where the
> >> bug was introduced. A comment on the Cc: stable tag indicates how far
> >> back the fix can backport. I didn't bother because this patch should
> >> apply back to 5.0 (skb_is_gso_tcp()) and the oldest LTS is 5.10.
> >
> > I get that, but at the same time the fixes tag is pointing at the
> > driver when what more likely happened is that the stack evolved past
> > what the driver can handle as evidenced by the fact that the fix would
> > never be able to backport that far as the function it was adding was
> > introduced sometime after the additional stack complexity was added.
>
> The Fixes tag seems correct to me. To confirm it I reproduced the hanging
> hdr_len values against 2.6.24 on top of Fedora 8. It was more or less the
> same script, just with different headers. I can't confirm that it hangs
> the limited set of hardware supported in the first driver commit. Maybe
> Intel could test it in their lab.
>
> It's worth finding new core complexities causing problems in drivers, but
> in this case the mechanism predates the driver. It really has been a
> security bug for 19 years. The switch was enabling TSO6 when e1000e was
> spawned from e1000.
>
> The fix not being able to backport all the way to the Fixes tag was a
> choice. It has nothing to do with the bug not being a bug that far back.
> I'm not spending time supporting Linux 2.6 or any pre-LTS kernel, nor is
> anybody at Intel or kernel.org, as far as I know.
>
> The attack surface and details of exploit have changed over time, but
> that's not a story that a single Fixes tag can tell. It's the story of
> IPv6 headers.

The thing is this has had cycles where you could do it and where you
couldn't. My thought is that it would have made more sense to tag:
Fixes: f2701b185e05 ("e1000e: Enable TSO for stacked VLAN")

Basically there were a number of efforts to fix this in the 20-teens
as all the extra headers for tunnels is when this started to really
become an issue. In addition the driver ended up being moved at some
point between so this likely went from being fixed to being broken
again in a few cycles over the years.

> >>> Much of the complexity that enabled frames to build up massive header=
s
> >>> wasn't until much later when the network tunnels and OVS started bein=
g
> >>> added.
> >>
> >> The repro script should work back to 4.10.
> >
> > Okay. However, that still only goes back as far as 2017 if I am not
> > mistaken. The diff you are blaming is from 2007. I suspect we should
> > be looking at blaming whatever introduced the ability to push the
> > headers this far as the driver itself isn't likely the root cause for
> > the issue, but instead a header change was.
> >
> >>>> Cc: stable@vger.kernel.org
> >>>> Assisted-by: LLM
> >>>> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> >>>> ---
> >>>>    drivers/net/ethernet/intel/e1000e/netdev.c | 34 +++++++++++++++++=
++++-
> >>>>    1 file changed, 33 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/ne=
t/ethernet/intel/e1000e/netdev.c
> >>>> index 6f85dab5c55c5..370776657d100 100644
> >>>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> >>>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> >>>> @@ -7355,6 +7355,38 @@ static int e1000_set_features(struct net_devi=
ce *netdev,
> >>>>       return 1;
> >>>>    }
> >>>>
> >>>> +static netdev_features_t e1000_features_check(struct sk_buff *skb,
> >>>> +                                          struct net_device *netdev=
,
> >>>> +                                          netdev_features_t feature=
s)
> >>>> +{
> >>>> +    /* Do not offload packets whose header lengths exceed the u8 fi=
elds
> >>>> +     * in the descriptor.
> >>>> +     */
> >>>> +    unsigned int hdr_len =3D 0;
> >>>> +
> >>>> +    if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> >>>> +            const struct tcphdr *th =3D (const void *)skb_checksum_=
start(skb);
> >>>> +
> >>>> +            hdr_len =3D skb_checksum_start_offset(skb);
> >>>> +            if (skb_is_gso(skb) && skb_is_gso_tcp(skb))
> >>>> +                    hdr_len +=3D __tcp_hdrlen(th);
> >>>> +            else
> >>>> +                    hdr_len +=3D skb->csum_offset;
> >>>> +    } else if (skb_is_gso(skb)) {
> >>>> +            /* Work around untrustworthy header offsets in this cas=
e. */
> >>>> +            return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MAS=
K);
> >>>> +    }
> >>>
> >>> Most drivers currently assume if the CHECKSUM_PARTIAL isn't set then
> >>> the frame must not be TCP/UDP GSO since for those normally the checks=
um
> >>> and offsets should be populated. Have you identified cases where we a=
re
> >>> seeing TCP/UDP GSO w/o the checksum being set up?
> >>
> >> It looks like this particular case is never reached by normal traffic.
> >> It has to be GSO without NEEDS_CSUM. This is only produced by a buggy,
> >> hostile or niche setup.
> >>
> >> When CHECKSUM_PARTIAL is not set, the csum_start/csum_offset fields ar=
e
> >> used for csum instead, or left zeroed.
> >>
> >> The transport_header field is unreliable when a packet is being routed=
,
> >> so you would need to parse the packet from the top to find where the
> >> transport header ends.
> >>
> >> Rather than walk all the headers for hdr_len, it seemed prudent to jus=
t
> >> categorically deny offload for these exceptional cases. I could be
> >> convinced otherwise.
> >
> > The point I was trying to get at is that the stack shouldn't be
> > allowing those sort of frames through in the first place. Basically if
> > checksum partial isn't set the stack should be rejecting the frame for
> > UDP/TCP GSO, not the drivers.
>
> I agree that this patch demonstrates how obtuse it is for an
> ndo_features_check to reliably measure header length, which is something
> that several drivers need to do in the hook. The issues being worked
> around should be fixed in core.
>
> GSO without NEEDS_CSUM is the biggest offender, no driver is checking for
> that in their implementation of ndo_features_check.

The point is that it shouldn't need to. It looks like this is
something that was broken over time to first enable FCoE and then
GSO_FRAGLIST. The way it used to work is the code required
CHECSUM_PARTIAL only.

> Using a potentially stale transport header is next in line. Several
> drivers are getting this wrong. I'm working on a fix, a simple reorder.
>
> >>>   From what I can tell it looks like the only valid cases for it not =
to
> >>> be set and instead it is set to CHECKSUM_UNNECESSARY on a GSO frame a=
re
> >>> FCoE and SCTP (GSO_FRAGS) which are both non-TCP/UDP specialty cases
> >>> anyway.
> >>
> >> FCoE was switched to CHECKSUM_PARTIAL in 253aab0597d9e
> >
> > This is part of the problem. It pushed through the ability for
> > CHECKSUM_UNECESSARY to be valid in an outgoing TCP frame, and then was
> > reverted back to using CHECKSUM_PARTIAL. That is what is partially
> > what is allowing the non-partial checksum through for GSO frames.
> >
> > I will probably look at submitting a diff for this next week to look
> > at limiting this as there are a number of drivers that already expect
> > all TSO/USO frames to have CHECKSUM_PARTIAL always set before they
> > start processing the frames.
>
> That would be great.

The one thing that it should change about your patch is that you won't
need to do the clearing of CHECKSUM_PARTIAL. Basically if that isn't
set you can assume there will be no offload requested as GSO will not
allow it through unless GSO_FRAGLIST

I will try to push my patch out sometime today and try to remember to
CC you on it.
