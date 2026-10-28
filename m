Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793181177;
	b=rPzN6a9LMFaX68dUME5J5JVkrajRRXBcp3f9Qr4P395jk5xT5pER0/jJlTRJpGqqt/Q4
	 rUMvMSFTSffAL4GBA+FOgY7Eaci5IshoBENnUQSVeOK9+LiiAt/51SpQCRsfhBAQWsaL0
	 SzjYEr5xaA1NOJy5RAZE7bv3AhLroTz25L+7vP2NEh5GYJR/C90A3LcGVTJj4i1miQ1Iv
	 OB+P/LhS1rPi9Fa9vhpggO7XEF4dcdjIEPMee8r++s6KrhGz2l4nuM5ziRNhmmurwzSh8
	 Gpov8ji47MHavXyLUGPltqmQC0MmRjgr8EhGk+y1pzUDpygVrSTsOr6Oq3frPkYAXJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=D3lktQzRjBCMxnd67QjaXopfijutifhL58W+FUrFYB8=;
	b=L7xzXsVkh0jjy0iEz0hQFeUxB1F8zRtOMspk7em/m7cjWCA4B8sR60FA2W5mIPsYVidT
	 kVwaotXrRkRW7TeXmR3ZFjxU0OFA4jxrT96aeIA9RPE/pm0F7AjyzN8Op/b/7wuuoSY3Y
	 iG7uRdSiWdUXo92Vo0oVgp0e3XWmGzYxpk8VwelgArqkX3Myf8EbcauSJ1dmLof8C7KQ3
	 dTWxPwdcLzxUlKUC17NTHVD6aeXpjnfbtIYJFNksK+HB6H6z7O5RW2WR9xY6q/lp446PY
	 GDYxtIDOYsbcH+Vco73S+LyibUF1ZP60i9LgGueTA70ZB7wNJXDKWS0ao3tm0pMiy5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pFZb2XAt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E07606A31C
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15E07606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pFZb2XAt
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b0ca1ebc8bso5935677b3.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 02:52:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793181176; cv=none;
        d=google.com; s=arc-20260327;
        b=sZOEM1z4DtptAinLu76quiRZw7umNHeh9T33gPqj1NjxxCqwVkMjM5+ocSfwPRFnJj
         /Z60+0C/t6WWOpTUmk2NmlEeabgUNU1X4V50iPLaPWc1A8yXP2SFc7kQjCuz1EIDLelb
         9YHVM5xpDJrIQJklL59RedHJg+/iv6grvEvcWfeUjoZSFHknb94w2q7pccniZ763FDFc
         YvXju8TxJLE4C2y/agxRJ8YkQh6aftAde6zryjYbV7h0CeH6IraclDL6/tqYGkvtSZF1
         ZM7HUcMGL62IEru/vgdPcR5GQRI60bIrmxFvDUWDCmaVMNOBgsk/zdx1jKRm/dK9oyVT
         jQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D3lktQzRjBCMxnd67QjaXopfijutifhL58W+FUrFYB8=;
        fh=3rM+mk4x3Nd7dZrGPPzl8nXyUwXhAg6S1dYaTlDEkdw=;
        b=cHfv6368TokXfWVST8l5VQVy/Z4ty3XrXDeh0ncKODuIojEMGaVYQLgiIG0Zmh099w
         mb5wnYz3QTfNlcNTd/K4fgG7WwK8fjEam4cPVvQFOEwS2/ML4ZBHTgnM5SY5MvLSpuIl
         oKyoDwp6imrL8OoJUJKIvpWgvzCsEQ+f4ceQSNa1P1FGo4ImUlgdIVaH3wI4zcNE0WJi
         MDkXkoEPPAstztfrNG+xVcGVz3XlVZOTEJJvmh6UqewOYL6NaFKinwUkGVumY9C/1kq8
         /IvhQidh0MuV5kNTK1JLETR9jYdODLa++LdrfUvpihE7GaA2KpbmMtDjoerae5v5MisW
         qsDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793181176; x=1793785976; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D3lktQzRjBCMxnd67QjaXopfijutifhL58W+FUrFYB8=;
        b=pFZb2XAtZnGYD6N28VqS+GH/SCVM33TI2Ri9LSwpn3jK1NJwl1MrWcvCjh2GUsVre+
         lHca5O9E6gteBL2ej6PgJCq01YsOcKo/Eq6d+WLd566yk70k9zmQeTF2PDxieWRdfruS
         BgylkzSxGO2HYLQ96Qwp+2EKUnxqx+mR5gUy+t27G+IcbB9UZkzSClcIP4zgw1kUdldt
         4XklihCX9AjdEJy/W7K3rWBw+JDQzET3qmaQjnYM76Y8S9591ZfMPJ1lorViW3ds74OH
         sjyY/VJmRgG3iSHs+Zjb+vDNPWHqlPl++HHLW/ev/xaeuC2FcHd9S4n5WZe0xJs9ic4x
         mPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793181176; x=1793785976;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D3lktQzRjBCMxnd67QjaXopfijutifhL58W+FUrFYB8=;
        b=iPC+gpjF+svbiXSpRyVNqLmPgMnMTx/cVRfInu49taWhP37uaKs2FmNUEbi6SvSsTT
         kq8BmXQDlALc/6Rhk2IJaDNVJbHSnyTkfaCOJg9gyfOxl+3l188jSAAhWhlqtaZKNpZm
         BFiTy0dI5dXLTK7WEmpBHkq8la95TPqwLsteMCfJwPeEl/FwbmfmMuk3aAMCiMDvHnP6
         gdUkZxSb8UQAeVMohkUT6Vy16E/mDmIjg+X0R2j0D8kGL0xAjZ6L5UP5G0dLw4iuUP2x
         cZSVyDwi8BStukYHccSiMrLxt1FTyBZynZ/Q3P4VAmbSltF+Uy23cvNRdO3K3nSNT01/
         7DUg==
X-Gm-Message-State: AFq9FYLTq/jyRlYGmtlLyI+hgGd7GQtIg1IW0ARidnEAa+czUbJz7Q19
	K5YRdwwgUfbAnSosQ/fOzs4ys81V0FN5Atued9rKbyQfKZH012O6M0tFeJu0V0+LqHVs226DN7Z
	iuFrSBHxmTFYV9GoAeJwfKqXVRwuOeYo=
X-Gm-Gg: AYBFou3G2isCt3JAM8DbIurYH6DSRQwbnqFi5tHyn6zI0sYMeeA2qwapeAIzM0FOg9Z
	XrMs7Jcig9D+TKLrzDzxh5hxYrTQC2vbRfs96e5YN10G5WQHf7VTSovco3Q5gEgdOjS8EztD4qb
	zjFWJxYf3f5LlpiGatdGO3Ryc2Gz2kreQJ3OU3CWriXVWQQurCnTWW/QygMVJtfrsImy12QfSyo
	VMKwO4onseDdXMR48ewf5bvL+I/w/ORQPOKpOTlmhB58m4K+I4tjRGJ4CudAAfOxzZTLqvZDhS+
	2e48qaJdUKLYOXzBfF3SgclhRcuC+ZmCYc2aouqpdr/eih0M4IfJjCLvE4Mv5A2lkPNurOt/fdl
	KRKqzl4ol5Yel2ePeY/iFOhT8BgnCt83KHN5sOswjuu25G93BO07NPkgY7E0GW3Se3iKANJFcXh
	WvqEEsWn2hOQmH/tXtCah99jpOnLEK7+645kBEGdrAXqtin1kEtpCVrS+Grfd+Pt11ZxEWUXfSt
	mXt
X-Received: by 2002:a05:690c:e3ee:b0:8b1:f47:9c07 with SMTP id
 00721157ae682-8b1b5c5c918mr12989257b3.25.1793181176092; Wed, 28 Oct 2026
 02:52:56 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027202230.3539646-1-florian.fainelli@broadcom.com> <20261027202230.3539646-4-florian.fainelli@broadcom.com>
In-Reply-To: <20261027202230.3539646-4-florian.fainelli@broadcom.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 28 Oct 2026 10:52:45 +0100
X-Gm-Features: AclHuK_FWUZgUvSrF0mCFDYzLoIVENtjKxoJUiX7kBb8nyaeRUKlIMuLAikj1Qs
Message-ID: <CAOiHx=kFqW3AgzQ3_zJBxkdXcokg8j3-Ry1meV6h-RKb5mcTgA@mail.gmail.com>
Subject: Re: [PATCH net 3/5] net: dsa: b53: clear stale state when creating an
 ARL entry
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 9:22=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> When an ARL lookup does not find the requested MAC and VID, b53_arl_read(=
)
> returns the first free bin index but leaves the entry populated with the
> last bin examined. The multicast add path then ORs the requested port int=
o
> that unrelated entry's forwarding bitmap, potentially forwarding packets
> to ports which are not members of the multicast group.
>
> Clear the entry before creating a new one. Also return without writing
> anything when deleting an entry which is not present, instead of making
> a new entry from stale bin contents.
>
> Fixes: 5d65b64a3d97 ("net: dsa: b53: Add support for MDB")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/dsa/b53/b53_common.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_c=
ommon.c
> index 559d4b360c82..0871a10d8cbc 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -1992,6 +1992,10 @@ static int b53_arl_op(struct b53_device *dev, int =
op, int port,
>                         addr, vid);
>                 return is_valid ? ret : 0;
>         case -ENOENT:
> +               if (!is_valid)
> +                       return 0;

Should we return 0, or should we pass on the -ENOENT? We failed to
remove the entry, so implies there was a desync between hardware state
and software state.

If we don't, we should at least report the issue. If we do, we don't
need to, as dsa will do that. Though we then should also report
-ENOSPC && !is_valid as -ENOENT.

Likewise when trying to add an entry that already exists.

> +
> +               memset(&ent, 0, sizeof(ent));

Just bikeshedding, but semantically it feels the memset should be
below the comment/dev_dbg().

>                 /* We could not find a matching MAC, so reset to a new en=
try */
>                 dev_dbg(dev->dev, "{%pM,%.4d} not found, using idx: %d\n"=
,
>                         addr, vid, idx);
> --
> 2.53.0
>

Best regards,
Jonas
