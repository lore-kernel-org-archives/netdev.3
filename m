Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E16449B32
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 02:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784599379; cv=pass; b=d7a9MRm77l4eIf9Lhvjc5vIvigiqSm8WBSKoHv9fl09b3IqpMCegu0OYaKilqLTDprhNQmSCZBN6i1u+ztNq6JUc9dbghjUQnTMYvfFH4hebgt/RykJL8W593LiLdr46Oe8kcOGyPGn1/eauzNeX3Sc2vUelwCbSBxIkuC/iZUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784599379; c=relaxed/simple;
	bh=yT/VtTTdJaorgr+hZZQGPuJaikN3LRJ61PctTC8dO5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cg0jT5wyjNsFGjhyO7BGOfz64wgxDyC6iSpwhXWVjLka9oC0eCwAMm2N1fH5U28tbJVuQzDJNXUQj1T7tdsepvnrf8FTkrwVyAt2IwJtpyIHtZb8GTLI+1gsIe+D1QBpXpD1Gx8JHl72r3dNLt3GHyNq19W7uQplE3nzvAX/iHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRSwIb6X; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRSwIb6X"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8eeadbc5e21so48218576d6.3
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 19:02:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784599377; cv=none;
        d=google.com; s=arc-20260327;
        b=Tz/O5eRz9KBwYyn326P8yeQVJdg31A30Kx6PYWHLbQLKh+n9NHVzJ25StbXH0v0WpR
         C92ZjSAn9gBCLxBw/b12L/WocKdUyHiTndjJpaHE2uZSJJDETge2/hyBoBSB7lSdoWX4
         VacEeyNvG+6Qst10or45w+hkVYFuG0/TrwjfybmojjwmKOAygRtUKvSTbsvcxYTzDdvI
         96w7wmiEHhlE9cpR6r900WQm3MBxg1t9TNIW3DnCd6RB0cCAn/1BMK25WdhbtBmNmJ79
         y5pYNzOB4NdGpocu1cpKp7yvsurUvsQyHoT9jsAwCIMyO/oD1ExFDUqSJJygQtpUwe/G
         fVhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cE2Zyr2eSJf9Qekko+oRVtv59IcJVwAN5q+st0cr2HY=;
        fh=1Tk4YcPDakgeKN8W1Zx9Sh5dYLRhAvXEMpklT7CabYw=;
        b=p8PeCv/QvBWeFCvfbr+VYVG6xZooDThVrWDYHq/sBm/lEJ6pAZtxeYZ0qukXpNig+l
         caZYd3mHFlU5QcS5k1576td2zKQjXfbEwEhsZ6bbuioupDF5cOIVJZTw+43A/bfLSAow
         SxBAGqqa4NmiUjMBRshjmLD/jqlvmChWgMBcTamX/zikUB4RdiV9e+vlHEWM2/Pi8+fH
         jrzUo2pCfFZfrpQqFj+tGhsIEZm9ALK/7EgUyE78cnlbXefFo8tx9T4EnlkjG9lPLZCG
         gtGnG2da7H/fbuLGWhFCruK/RzOleW0vmSQG6qI6o/o52OKO4pWJ+E8pVD5foMkdehfX
         lxig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784599377; x=1785204177; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cE2Zyr2eSJf9Qekko+oRVtv59IcJVwAN5q+st0cr2HY=;
        b=eRSwIb6XWrLMl1FJvhhZd3p5ouFZ+uf1ucDVLw56ggdOrlTSa2Op6Yr57fTRCI0CYP
         ita3bAnUJG5vmZWW7TdjHZbeassLWFvSwkXrLbc7dbtwkiIXJHR/wriOhYH9PAFTXdYq
         mTJslVycPts2RaZ92IFZ6F7GkVJdMxAn5taObjPuDpUHllaNZbglK9G7CeLjFPE8u3b2
         gyJu334ywkyPPX704ebLsy1buP+IFGbnHnFFHiIFEqvju+hauX8QvOcXSvfhc94+ooho
         SqdTMUHeoQsupTtcYdy/uT7kY1jaI/XiTkmt/p/zg8ZmnZGVR0ktrOQBU3eIrog/U7sI
         Js7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784599377; x=1785204177;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cE2Zyr2eSJf9Qekko+oRVtv59IcJVwAN5q+st0cr2HY=;
        b=Y2dzNC9U2QhBRwYFO2oYEk8Y0/VsUnFpX+3NCd8z2SB8l+H4YtoROQ5zMmQryCTqFF
         FWtt7gMViYadQLu/VogI6JNs0Pq3Ygx6h7RPJj/InSlpDBcu/VwYwe4oY6+HeJkquUkf
         KYo68n9ESz06oFYKPdgtsSPZGc9d43PMH5kamE/KuWvFL3HhPn53W/9r9LtybXCmpgxH
         RXKlovUEhgQMpxpEeSXlGbkLTSY+1MhndS2H7Y+sW86f3Gs3JDxc0tMZwGwomX2CFSmP
         ovRH6Ht8YmVyUuRzEPZXq/9SFKkbwkEOa3x8oTbHsb3bF4F5/oN0tRsjBQxdPmJQeAsR
         7nsw==
X-Forwarded-Encrypted: i=1; AHgh+RrG+Hd8/znI+KwcmFrWJ0DCz4phyr4YIvW/cbyfyspk4hthKmUPZ+jTorPsPLG1olYXS8vFF3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YySOgZ0CPKydo/qrPi6Ep2m5tRrd02XPC7PTfKCTMplzaWAsoeO
	QY9lrEQKowJbkYcf6CdEFRfI8vT+xXJQ8kzhddtpJV7HhMDHZGrwThGsgnvrglBsSzdzI/VOE1C
	a6CBXa5LeMb8FB8pFoXY2QZhCDmiTQkw=
X-Gm-Gg: AfdE7cmuaidE/+8ONmQXFqaunO8fivaEJMaMynMpnRXfP0Z0jNXiOwj1CwNuaIyqceO
	g6/s+xlNYEdMysgH9Dl+ZXI1AAz6iO+Mb/53UVFuRssCU9QMIb6QmrTyLUKVk/MVHUDN7IM/ocO
	g4HmZMfGcJBKs0sbtm6meyPjy+IcTI1oiAJJLybr4zKkkOpf7SvXr72pQy4Bgu83vd1vgFkH+mU
	AWbcGNsUNOap+Ypoh4oEo0xQ+3U1AkAVMDcCnB1rWN9AQ1Xk7GWB0x0wSTuO+605dMFE98J
X-Received: by 2002:ac8:5fc7:0:b0:51c:207f:6524 with SMTP id
 d75a77b69052e-5213cdcd357mr155849191cf.37.1784599376724; Mon, 20 Jul 2026
 19:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1784355642.git.xuyuqiabc@gmail.com> <aa8a1d8dcbac8a13dbdf077a642a66f4c5d81e4b.1784355642.git.xuyuqiabc@gmail.com>
 <c357f846-d42c-4b98-acc9-46b751818dca@lunn.ch> <0c037f98-f219-4851-9a06-e83b25ca0f7e@gmail.com>
 <c9a39c7f-cdad-4e8d-b516-b727806525a0@lunn.ch> <f7tmrvla288.fsf@redhat.com>
In-Reply-To: <f7tmrvla288.fsf@redhat.com>
From: Yuan Tan <yuantan098@gmail.com>
Date: Mon, 20 Jul 2026 19:02:45 -0700
X-Gm-Features: AUfX_mxddUEKtRW-xPOQbf6Gr7rzNhembjy6kNyI38YjJPiBJJJfe8Qelm-7X6A
Message-ID: <CAPuPA7KiuA9agAXbXFRA6-wRHe6=GPFu47wjc-MY-twHQXTF2w@mail.gmail.com>
Subject: Re: [PATCH net 1/1] openvswitch: Fix CT limit teardown use-after-free
To: Aaron Conole <aconole@redhat.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Ren Wei <enjou1224z@gmail.com>, xuyuqiabc@gmail.com, netdev@vger.kernel.org, 
	dev@openvswitch.org, echaudro@redhat.com, i.maximets@ovn.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	pshelar@ovn.org, yihung.wei@gmail.com, tonanli66@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 12:30=E2=80=AFPM Aaron Conole <aconole@redhat.com> =
wrote:
>
> Andrew Lunn <andrew@lunn.ch> writes:
>
> > On Sun, Jul 19, 2026 at 11:54:31PM -0700, Yuan Tan wrote:
> > >
> > > On 7/19/26 19:52, Andrew Lunn wrote:
> > > > On Mon, Jul 20, 2026 at 10:14:16AM +0800, Ren Wei wrote:
> > > >> From: Yuqi Xu <xuyuqiabc@gmail.com>
> > > >>
> > > >> Packet processing uses CT limit state under RCU, while netns teard=
own
> > > >> frees that state under ovs_mutex. The CT limit pointer was neither=
 removed
> > > >> from readers nor protected by a grace period, allowing packet proc=
essing to
> > > >> dereference the freed state.
> > > >>
> > > >> Replace the pointer before freeing the CT limit state. Wait for in=
-flight
> > > >> RCU readers before freeing its contents. Serialize CT limit netlin=
k
> > > >> operations with teardown for the full lifetime of their state acce=
sses.
> > > >>
> > > >> Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
> > > >> Cc: stable@vger.kernel.org
> > > >> Reported-by: Vega <vega@nebusec.ai>
> > > > Is Vega a person?
> > >
> > > Hi Andrew,
> > >
> > > Thank you very much for your review!
> > > For context, we had previously understood that using the tool name in
> > > the Reported-by tag was acceptable, based on examples such as
> > > Reported-by: AutonomousCodeSecurity@microsoft.com and Reported-by:
> > > Anthropic.
> > >
> > > https://lore.kernel.org/all/20260630171016.11c02dec@kernel.org/
> >
> > https://docs.kernel.org/process/submitting-patches.html
> >
> >   The Reported-by tag gives credit to people who find bugs and report
> >   them and it hopefully inspires them to help us again in the
> >   future. The tag is intended for bugs; please do not use it to credit
> >   feature requests. The tag should be followed by a Closes: tag
> >   pointing to the report, unless the report is not available on the
> >   web.
> >
> > If you believe this is out of date, please submit a patch with new
> > text to this document.
>
> It is common practice to accept syzbot reports as well, which look like:
>
>     Reported-by: syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com
>     Closes: https://syzkaller.appspot.com/bug?extid=3D36256deb69a588e9290=
e
>
> (see commit 539dfcf69105d8d3d4d677b71de6e5ede2e6dfa0 for example).
>
> > I find it valuable being a person. It indicate somebody is bothered by
> > the problem you are fixing. We see a lot theoretical bug fixes, which
> > in practice nobody ever hit. I would prefer to spend my time reviewing
> > real issues, not theoretical issues, and the Reported-by: is a quick
> > indicator of this.
>
> +1
>
> In the case of syzbot reports, they are real actionable reports that we
> can look at and address (and I agree with your sentiment of wanting to
> focus on real issues).  They include the 'Closes:' tag as well, and a
> reviewer can just visit the link and see the splat.  If there is a
> report link that this Vega tool pushes, maybe that would be acceptable
> since it's the way syzbot works as well.  It also makes sense to update
> the documentation to reflect how it is used currently.
>
> As for the v2, it would help my review to include some kind of
> reproducer description - I usually try to experience OVS splats for
> myself.
>

Hi Andrew and Aaron,

Thank you very much for your feedback!

In fact, all of the bugs for which we have submitted patches have been
reproduced with working PoCs. We also include detailed information
about the bug, the PoC, and the QEMU crash log in the cover letter.
Previously, however, we did not send the cover letters to the public
mailing list due to security concerns.

For example, this particular bug is a use-after-free write that can be
triggered from a user namespace. Based on our analysis, we believe it
is likely exploitable for local privilege escalation.

Going forward, we will send all cover letters to the public mailing
list. We apologize for any inconvenience caused by our previous
approach.

In addition, we plan to launch a website (in approximately one week)
containing the bug detail, PoCs and crash logs for all the bugs we
have found, making them easier for maintainer to view, browse and
search. We also plan to include bugs found by other tools, such as
Sashiko.

Besides, I will send a patch to update the document.

> > >> Assisted-by: Codex:GPT-5.4
> > >> Co-developed-by: Nan Li <tonanli66@gmail.com>
> > >> Signed-off-by: Nan Li <tonanli66@gmail.com>
> > >> Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
> > >> Reviewed-by: Ren Wei <enjou1224z@gmail.com>
> > > Please take a look at
> > > https://docs.kernel.org/process/submitting-patches.html#sign-your-wor=
k-the-developer-s-certificate-of-origin
> > > and the sections that follow. What is listed here does not follow the
> > > rules.
>
> After reading this document, did you spot the second issues?
>
>       Andrew

Hi Andrew,

I have read through the document several times, but I am still not
sure what you mean by the second issue. Could you please clarify which
specific issue you are referring to?

At the moment, all of our patches are reviewed by Ren Wei before they
are sent out. Are you referring to that Ren Wei is not included with a
Signed-off-by tag? We did consider adding one, although I was
concerned that including too many tags might make the commit message
unnecessarily cluttered.

Thank you for the clarification.

Best,
Yuan
