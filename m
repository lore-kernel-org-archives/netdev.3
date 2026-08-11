Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F074F3128AB
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786460534; cv=pass; b=bc8o0hbmUmedW52mctXZOKLHxZUHrch83jMwgrOBt/avUWP49SXopj0QSFUu/Uuqqxd7QW6nSLwP1xfy1CT8QJokrmUlRDUcxxPiww8xkvwp+OZMzZNN0lWdBDkIj7HPd7iWxhMUyXuVYH9btW1ArRiFTTlcqzG1+xiHsFbGSh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786460534; c=relaxed/simple;
	bh=j4vbTkMHrqahFcFEYeT5VCU61Ma6CvquGXAoLyjKjpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZqhXZPyFNrfT0dO3BLD0jYKxbCrao9l5OrQuJRK+LlYEWm1EU8zCaDmwsTdEEmvUlyESKP81aKYKaOJBURMSxY89L3bGbII8MCJ5fTQLeAk8ifDtcQGi1PQiczME020EfDIUxRhLhcXkHy5Kl157BAUFff1jK4oE7zKu7nYtfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nreC9w+8; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nreC9w+8"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81ed2a00f12so44370497b3.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 08:02:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786460532; cv=none;
        d=google.com; s=arc-20260327;
        b=Qd4gl8c/cu9ZoUKyxBCfPNXlK6vi+LkqEyNgYSOqKYzSgv32CG2KfDp4oBgm7YVYIa
         0ReKbVHettzFqVQEi0j3MR72k/fZai8mWTqO5+lpLQfDYN30RSvTec5WQRa9SY0sPnNU
         zyVOkaXG3b5pPDd5AOvWR8oGzfXEcsPXH1Km/qkoNSjhojdyovFLbrPm5X7RpJ0IC9WW
         MuSe7XvgQp/XEZLcZnVj/LUX5tWsZArJ4bgDMxrrjcxQbfqCIJBoyHRi1dviA7H7TDOJ
         ZvgmuPts0msWkoSWo3fw9TxtY9BtdcnN9OGupMCMEeUvRRuUFq6PsSWNbJYn2V+uHnPc
         Kcow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DOFGdGD/+2nP6RQWzZ2s2mHQTcJH8q2oU5hHFRYmAkY=;
        fh=Ra1H9YUl7kjHHWO4GYW8LdNBZG9Q4QkTE28+dNt0cSI=;
        b=DEZYQcGPeloOw9W721GNkSX+AKc6df/M5zcw5hqJozq4ixaMgX8QSK7Vi4xbrpqOP9
         KU+MwOuXVxdPdXlB4HB9naYCDiknCa9HYQ3qdr9WKLCJvpqNagC2urf6RpRgBjKIaJFN
         A5d6dJKr1vuq5gy3RQa9bDsHfAOoVkIk08ocR2DoJNnZGh9gezWOPLoBuyRtDkNVO1wf
         5hogzFMDr0cA6GwPKSfzJ4LwOcavjQk+0pSljbMvqbYUgBG3WibNvXKqv6OS7wpgn8VB
         wqK5/k5lOX0L7wuvBP1ILi0fEWhYsZcJEn2W2yQpGUp+kJwiV6I73RDl9L1WrJiIk7j3
         7/aQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786460532; x=1787065332; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DOFGdGD/+2nP6RQWzZ2s2mHQTcJH8q2oU5hHFRYmAkY=;
        b=nreC9w+8mbwcmAzCTMzQ+kg4JRjBD6fexMUvdbe2BD3y/UqIiu4ZkpLcU8o007LcS5
         IO3k5POj0JPLJuX2EEbPayeAF0TOpLuHfWfsUYF5S+WamMYBw6eFyF6pujow3PIAoZ+U
         IjMlCixpxFtxTT/omasGzsMqUPZ7TqWj2rGHaO3qLGQUg1FN592r6SqFztSU2+6i3TkZ
         o6B9AYocblNvq94G0wv5OKSAEOTXMa4tSDFXzpTzImwmj8+Z0vzFvt0Fp70Luyc95nRP
         mVcnMpsEYtrAfDidFvUayUlMFZnE5b95p2AWpYErtCWpODIRz5mzjsNtT6DKntf1KiI3
         n4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786460532; x=1787065332;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DOFGdGD/+2nP6RQWzZ2s2mHQTcJH8q2oU5hHFRYmAkY=;
        b=XPwsZ9qdMCoNe669D7fl1qSGrm0MHW//69oQcGivOF4Ovzxn3NUciP25x9zKXWEbv8
         hYy9Ru00VX5zkZP+mekRjvF4RiFoUvlQ6YQEjvG2Pbj3S2YiIADoZgyVpU0TfGKO1Xow
         7MNSX5BlV6Q1V8VLZswq1hcxZUfB2ye8IUAS/n3TmQYQP11dnX9F7YVwrTUonFPaolvE
         5RfJuXE/ga5m/YgpxrAxO2dH/3yXHvpE5X/TmS6/NLU4hFa2xof9j7DZHeav/X3gfF+Y
         GT+YzeY5WJ3hQvTxgfj5aL+TjUjXabLF1r2Jvvzzl3c1vJY2YLrLIP7mPbzmYb7Pe7xy
         yxzw==
X-Forwarded-Encrypted: i=1; AHgh+Rr2/xpksmGmFnSQuU0yT87suOKEpdEpxDHoo4RMdKftnDHVwKfwwSeS5YGfh2KRlDpZdOdcSVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP9zLKWELWG7xmN9KWqlJmw4R+eTl7+hILzLBpP3hRgXgD10VY
	zkRz1KjcY2jJDLrUCo4znCrNqrp0otbfVD11/kMbK65yE3c/wtjo+mrvp+6PVwl05QwI9Cl653H
	ziLq+oq9f/WlSqRgZfKS0kSGFq47sS/0=
X-Gm-Gg: AR+sD13dGWonMlztr3jN7VxGFqYt6VUQ6fshF45tj5PNcPv1XLpp98ITbSdMl7yI/Xh
	oWMx9sW+NUtdSgJCBHAQ7lqclAAjWUXANMn7M36/vpbFxRyxr4zdN/jUfvTDb8PFQiwf+N5sOD1
	rJ/9hF8o292wPJlkN64azdIAfonsPIoTJDUIWmtaIUxQ5LYgkcMaVIRUc+AUBM7e2RK17aQGCoI
	NkWntYEa8FKKUgqv0gTZNudtQo/a4nPDof7R1GLapKd43YLo+Ruw8QLYU/+V4TnzU0mBXKwinAh
	l0p08wFTBzxU5kdudmPTS3PXSRIORc3nxZpzdQf6KGqo4zLy7zD3w3Wdrr05pTNGj5mW5/1VRZZ
	LbvbgE2YQGjTApfe7faaBDvE+Ww/OJlk=
X-Received: by 2002:a05:690c:88:b0:7ff:1399:9317 with SMTP id
 00721157ae682-8303dc941b6mr6987997b3.11.1786460531677; Tue, 11 Aug 2026
 08:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <anpxFdwNxk0XwPjQ@makrotopia.org> <2026081139-strenuous-greasily-f4e5@gregkh>
 <cb0d42dd-4755-49a8-8a05-297e4283914e@oss.qualcomm.com> <2026081133-crazy-enquirer-97ce@gregkh>
 <154779e8-5f73-4f3e-8618-104effb85538@oss.qualcomm.com>
In-Reply-To: <154779e8-5f73-4f3e-8618-104effb85538@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 11 Aug 2026 11:01:58 -0400
X-Gm-Features: AUfX_mxYe-nElnQSrdmasbUvVVMeEoXpj9A_1Sq8Txj9OmoMmXB5_-_tVdXTCcc
Message-ID: <CABBYNZLHnKnorEbp=LuxcvCUBOpoKHZbV=R9DYzjJyOiFUU06A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] device_schedule_reprobe(): core helper and conversions
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Golle <daniel@makrotopia.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, linux-wireless@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	Johannes Berg <johannes@sipsolutions.net>, 
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, Kiran K <kiran.k@intel.com>, 
	ChandraShekar <chandrashekar.devegowda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Tue, Aug 11, 2026 at 4:51=E2=80=AFAM Hans de Goede
<johannes.goede@oss.qualcomm.com> wrote:
>
> Hi,
>
> On 11-Aug-26 10:07, Greg Kroah-Hartman wrote:
> > On Tue, Aug 11, 2026 at 09:32:45AM +0200, Hans de Goede wrote:
> >> Hi Greg,
> >>
> >> On 11-Aug-26 04:33, Greg Kroah-Hartman wrote:
> >>> On Tue, Aug 11, 2026 at 01:47:17AM +0100, Daniel Golle wrote:
> >>>> Three in-tree drivers (iwlwifi, hci_h5, btintel_pcie) schedule a
> >>>> deferred re-probe of their own device from a work item in module
> >>>> text.
> >>>
> >>> That's a mess, why?  Why not fix that up to not do that?  Thousands o=
f
> >>> other kernel drivers do not do that, what makes these so special?
> >>
> >> I can only speak for the hci_h5 driver where I added the reprobe code-=
path.
> >>
> >> The problem is some of the Bluetooth HCI devices using hci_h5 loose al=
l
> >> state during system-suspend. This means that the HCI and the Bluetooth=
 core
> >> end up being out of sync.
> >>
> >> So we basically need to tear down and re-build everything including
> >> e.g. the firmware upload which happens at probe(). Doing a full reprob=
e
> >> is by far the easiest way to do this.
> >>
> >> I suspect the other 4 users + the pending driver which triggered
> >> this are similar.
> >
> > Full reprobe feels different than the THIS_MODULE stuff, which is what =
I
> > objected to here.
>
> Right, the helper from 1/4 to safely do reprobe from a worker actually
> removes the need for THIS_MODULE stuff :)
>
> The THIS_MODULE stuff in the open-coded implementations is there to
> avoid someone doing a rmmod while the reprobe is running. The new
> helper replaces this with some checks in the workqueue function
> checking the driver has not been rmmod-ed in the mean time.
>
> >> Sure we can do the whole tear-down + setup from some worker
> >> scheduled at resume, while keep the driver attached but if we need
> >> to duplicate that over 4 drivers + the pending driver which triggers
> >> this then IMHO those 5 users are a pattern which deserves having
> >> some helper to do this through the existing probe() + remove(),
> >> rather then requiring those 5 drivers to open code this themselves.
> >>
> >> Note that we already have device_reprobe(), which has 15 existing
> >> users. This series just adds a helper to do a device_reprobe() from
> >> a worker in a safe way.
> >
> > That feels a bit better, as long as this code really is "safe" :)
> >
> > So, how can this be tested and fixed up so it isn't a RFC anymore?
>
> To me it looks like the main things are:
>
> 1. Agree that a helper to safely do a device_reprobe() from a worker
> is helpful (I think this is done now?)
>
> 2. Get patch 1/4 reviewed. I can do an initial review but I'm not very
> familiar with the driver/device core internals.
>
> 3. Test this. I can test this on a hci_h5 BT HCI that will hit this
> code path.
>
> I'll try to get 2. and 3. done soon-ish.

The 2 Intel drivers are related; they are part of a combo Wi-Fi + BT
solution. This is why they attempt to reprobe each other to recover if
the entire system (not just wifi or bt) has run into a fault and needs
to be recovered as a whole.

As for introducing device_schedule_reprobe that seem to be a great
initiative, thanks for leading it.

--=20
Luiz Augusto von Dentz
