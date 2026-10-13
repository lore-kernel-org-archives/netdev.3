Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248C237B413
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 19:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791920800; cv=pass; b=hVQXqVW0THmLtQBR2+iAVEu/AwexX23DjaBYcH+JySP9jjfAoAJb2myITRF0e1WE4OkCNhtyAFbSK6XTDm7TbhHiDW17E3mqboX+NnmlMOmeh405+2BQ6UCgWHzAAf9Kk732TPeMDYIRFx1KlMeOHIWLjxSxEo+NEq8pmmaJGhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791920800; c=relaxed/simple;
	bh=FXG86Vc5Z3HtOtD7Ma7mNf0CfsAgAIGs82fO1RvGgYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGXvRJ6GCAInYgm5ah9+W73FoOn7F1iW/ZvetUv4PIqe8jh/JvsKUYYPIWIrXnxiL2HUVBJj9vTNxC2HFxR+C8IBL22FcFNHH/+wYI0Uxxs7Ew2HsrJd4GwLI+bdz46qTQ0pvXxlyH6iuH2jvB/x2//7XSD1oH3pCofq+y8mECY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ncq/l4Xs; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ncq/l4Xs"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b203527bceso401618a12.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 12:46:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791920797; cv=none;
        d=google.com; s=arc-20260327;
        b=XWuoTauE0Jgh5MgaRVLPWAbg2M1ATENKISDXxMSYlEuHFHRGh4LSLQpjuqT0U7QK34
         HGso+jjDl+GFBQcO/HXdq8nyZ/eR1SCBwo+IsNojDvX+MlQr15H4copioc9c940djirZ
         k08J+7NdKyK8sXMdNIAe8hqChvnhHzyvEhaluJIKnL7SJE/3k6nG3XbtvVuRd2fX06yx
         teQJJnsQjMoEA8w0xDFEOzq2dt+WXmWSpXfba2YaILElyF4cQbSHkgZuzHF8HjvenJ7J
         HoDR8SXB0NkH+cnvFyX8Vq4O+FiYUTyViH7+9EZN5BzfCXxZfKGx5oSFdCNwyRriJo4T
         3BQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CVKDBAWO9v4x/qHowfYZV6oyH69UJO9Z+8aTiczsXHQ=;
        fh=zT239D3uluY0S4SaxSt6v9qsARJBm0AH8ZIzY6AOLC8=;
        b=WYLnFwx8Q4R7pul2gQD1tL9u96XYtXNLVTttyHeQvQde2w2M2CRJm6kE/dksYysBR6
         S6gHybyYg9G+hby5ZidQh8uA6GyC7xbj/6gYO5r/NqQ4XMRGLy98u8WKgmtN3vI6ojM5
         Ah/G3j8MJ/sYS9b8kAV8gcb3E4wYq28lKWz7yl5kQLSABTNQfXYtYh31f/1Ktas5l2qD
         x7jiYKla7Beoji56zk+CTaPVmh0gChWfgIeF7lpTUYmMa0NaiQUpTrVRNahApXdyXC2h
         egX7gLlSiscd4HKWNQD8cgOZSokmIvym2dXwCJeeHngQCznXqAvNShpiBK6N/+ZikGEK
         2T6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791920797; x=1792525597; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CVKDBAWO9v4x/qHowfYZV6oyH69UJO9Z+8aTiczsXHQ=;
        b=Ncq/l4Xsx61d6s5Zq7UQjrcZuzv3YTonNTtufS15woh21syVCmTo5TdTkm2roADliI
         hQ48nB3OWtGpFmcU+nxqgG+WyO7eUSx3LFdaPWvTF7y41v7LKE4RULxPNFTvu2YN71tr
         MkxZWrUkAEIq6z9ZaF/8ig1H9ztjhbtsDCXUYbwwhiQlUypNJETpk59b9RxWsf8Ngl5F
         0oc0e4ARG69Vl33znWek5v64n0Xbnm6IU8Na8KwoB7VHcG3FYdDFNDs+xdNzTcuxUF2j
         flyKkJd5NBquYAVeRUgLMOGWP8bpRZKyOmzrQxABTqdRFJBoO8I/RJAgtkRPNt2KxNba
         6xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791920797; x=1792525597;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CVKDBAWO9v4x/qHowfYZV6oyH69UJO9Z+8aTiczsXHQ=;
        b=RT8SmoU4rp+eUKt7m6yvdsTMsZ3CqAAFi6TUj/CljmB8NiE7u309YcD70aH0fuA5jL
         elvxfiEroFs2FPa8nRU7Kj96upfMlBXulGPg7SHx9HbC56Ug5a8AAcU/2hPgjZ5dKWSM
         78+5af0n/OLQdqB2tgFjJsDbNXN+ITkfj0HLqTmVSHzeQVXJCUMEwMW2N8ve67gEyqw/
         RTQJHceF29gwUts6UXM9ZhDUt4rpLF8mx7BhSzV/zuaXH5ip+Wr5u0F2Aj2MyFkcY9gE
         5lLPAfT0QXd2IxY1/U31olpaF93BAY3nhjoWjm5A56vw7UWelebW4lhM97h7pwFBnP0G
         SepQ==
X-Gm-Message-State: AFq9FYJQWPY7nSrL7Y5X9ifTKaE2YOGUmtg31Aib9icxXEPV4IEr0dwD
	58v3mi5b1zp0SaSuY28KcrS+TYj/D4rsUl2zmGOQFsHTlEXnrKfDTURMrbVvWcwRhZHUBa9wT6+
	UqtCTOKAxpwt71IMJoFSNwWuQWAVxMgw=
X-Gm-Gg: AYBFou2Z45wCzh7Iq3Im3Rn2rXP1ltwFn1qPWxl2FFtJLY8Ot4lR67fkbtqfGru+nBf
	M46sJL1Vll8gXhVQZh8eJfhMHKUbkipxZJ0HcFqrEnVYBIIddoUONDHxDj0rtCpXeYs3r8rvmgr
	4Quow+4YQLPGHTCXiEhjwCBPxOIxC1HXVAxdis3D3xXzcFAeY7Z0RTwCjj2Qie2ZktuDeCKj/Lm
	sOJuZ5F8v83ED/edExt8eewEoPyPlwAaB7AAu5v2NzNiW5CxKd3viIyA2TzR83FH/ZXYNgBdxsH
	t5yuCs5/XzI/cx9VBuZ9hmqMfe+RQ4XyzqIvSmHzAU4z+wP4HFVZHFDgpYKW3atBeUguEChv+pe
	EYJ8/i1T/M12Tt2YnpFrbthNt/ZXU/68oWXsQBwunzftRV88IvFhyD3d3W8tQ5RvohkNS/Zkfry
	vBZxU/RVoDnvgX3LkYhateTFmz11wUjhQJXjpSbzNSobDc
X-Received: by 2002:a05:6402:1e8c:b0:6b1:e474:e0e0 with SMTP id
 4fb4d7f45d1cf-6b1e474eb16mr2804797a12.9.1791920797110; Tue, 13 Oct 2026
 12:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005-submit-phylink-suspended-stop-v1-v2-1-8b8e5d53dfc2@gmail.com>
 <224296ea-f196-44f3-91d6-1461846c55a5@lunn.ch>
In-Reply-To: <224296ea-f196-44f3-91d6-1461846c55a5@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 13 Oct 2026 13:46:24 -0600
X-Gm-Features: AclHuK_-ExkCTDuO98uNJR7veehspk26g_HVMQrxEAv1f54ELeztHi6cVQvhtyw
Message-ID: <CADvTj4qgcXE6azsNx-Wg5afatezLeuctGR607qO1WhZSmuqzBg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: phylink: allow stopping a suspended instance
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 7:22=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Oct 05, 2026 at 01:09:05PM -0600, James Hilliard wrote:
> > After a failed MAC resume, a driver must be able to stop phylink withou=
t
> > resuming it and reconfiguring the failed MAC. This is needed when recov=
ery
> > leaves the interface administratively up but detached until a subsequen=
t
> > down/up: ndo_stop() must finish the suspended phylink lifetime even tho=
ugh
> > the MAC could not be restored. The missing transition was identified by
> > code inspection of the stmmac recovery paths.
>
> I don't particularly like this. It feels like a workaround for a
> broken MAC. It would be better to fix the MAC so that resume does not
> fail.

Fixing an identified cause of resume failure belongs in the MAC
driver. The intended purpose here is narrower: allow orderly shutdown
after the driver has returned an error, rather than recover the MAC
through phylink.

stmmac_resume() already returns before phylink_resume() when hardware
setup fails. The associated stmmac recovery work keeps the interface
administratively up but detached, allowing an ordinary down/up to
recover it.

That leaves a subsequent ndo_stop() needing to finish the suspended
phylink lifetime. Calling phylink_resume() just to make shutdown
possible would reapply MAC configuration and restart link resolution
before the driver has successfully restored the MAC. That is the
transition this prerequisite was intended to address.

> As far as i know, this it theoretical, only triggered by fault
> injection. If we find a real error situation where the MAC cannot be
> resumed, then i will consider it. But until then, i prefer to reject
> this patch.
>
>      Andrew
