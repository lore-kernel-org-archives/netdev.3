Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792804663;
	b=B5Ue1xex9hmhIlX5dHLnFgIBcZTtCrrYlpn7RGNSwkAcQjDLuq3B7Iiw2lcXYl8NBhYd
	 T+K+yYk+dnA5gLJsvbvMvZz8gQj1ei/ldpYMPDn54l6eNsaMGYjJZCOqiUW0Q6mVI4lLA
	 jyXpvMnrVWc25yHyTUXWHrLJtegIhy+xeXlLH8lSDjbMK/C48f4vNqmi8nE5ZZQr/00Iu
	 /uaZg9so8ZhjyhEu2iTmiYxv2lfWNM/k3HinJ+j7e9udMYazrDybv5w+9g3MFMBfIo9xh
	 0dNNz7XQQhXxnNk/2zwdBwYLejsYsbirvimCjczVWqeAuONr8XcAEv91miK0nDac5xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792804663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type:Content-Transfer-Encoding;
	bh=ukpmY9ch5lIIoawnCt4Ss+0SzKid7XBH5xM/xi/5vPs=;
	b=z1T80hQvhY8CRvJAlOSwge2KPKO1b0cr9yfF3NwWrwmDJRljAMTjbhTAZhhBVWKDXNlX
	 ixS3ix+HCQ6W7emsI0eP6uig8qgJMW+5JTcjKOSsmsdIg44fFgs0/adrwNOj3Gwxx+l1A
	 RbJKQbXHofViDPhz155ezXXjupYtiO1Qv0roOZ06zQeLKC4qvuoHP9xO1wDkYiKBQq8Bu
	 Xtkpw4CoSDqaK4Ok0sUqhX/AfK48j1Y3rrbY/yOb1vMNrA+xpyjkeedK//J+N0/kAWnAq
	 9vKXtkFqwA5hlPn5Y64lFFSWg2ryonMRkQfNsR557AmgZ82V1dJaoCyyS06x6pdovWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mK+nL95C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696E9606A31A
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 01:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 696E9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mK+nL95C
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c423b145922so191897266b.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 18:17:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792804662; cv=none;
        d=google.com; s=arc-20260327;
        b=gVm5CPUCmG46Viw7g1gMk64Aa8X3wTcOL2N6s9RT7lUiDmi/UgYbLU//BBn+0t/EnK
         0vPCxPFGhQ4xemWbwiaDZjvIDZuioPsj4thTBQVRZOxpbrteaZzSNVQFIwHOGiSBlBn/
         tiBCz2hgFD8EUjiB7SDdPF5ISdl5lpvJXYGEu0JHUJhUHCHijzQ/dIuZGi3tG9ZRCopa
         IjTq7qiohFItDKvqLQHcBmjW+dm2MUo1Gx1daUxjPj3mrlzodRQl05iBPI65jGvqaZ80
         17sQJ4RLoMPqD8LDWyGhnFKsi4BQq9xnEFXzJZnou0LC2sRmLi5hA2PGSXf+gkURlI33
         VHUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ukpmY9ch5lIIoawnCt4Ss+0SzKid7XBH5xM/xi/5vPs=;
        fh=P6zhd62WDGH3fWiLXAyDDbLyJVMF4z2wxwUlSzbTKk8=;
        b=nIoctxz1Hfj2JR3LrCbzl36pwM/OebVll1xi9iSqy1BTrYZTSqA3e88Y0s3o284pJ1
         2rRrpXowinOSVeXkOkQnSNndE3/tWEASs2R+MiF9UBBGxGRWoU7E62xku9F3PSPShEBy
         l4c3aO2WDxVozDURNKeNkHkm/U0CK7iXaPxOTRev+u4tJyUI7weOc8ORopBB/11Pwaob
         ABGpWxpgVRoK/GdznwN6SRG89kyRV2Jen9BQJZiiZRwAPY0M0QmdSSPczdbtJYJbDQDB
         SL97EyUGubwdKHTMFKVEjKKGtjxGYnOh2Mll1SZgWzU29hQTF3UtatFQgcHxCcfs1PNO
         EFsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792804662; x=1793409462; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ukpmY9ch5lIIoawnCt4Ss+0SzKid7XBH5xM/xi/5vPs=;
        b=mK+nL95C9DLeLdYr8bt2DxsWWIowmT1xsM8HmV9c+1lRZGBnOO/oRjmQXLunq3DoM7
         4hX3Umid8KXXALP82CMlEpZoxfqLRXqqPfmJ2TUgquF069WtSeU+Ls6G6vMTIaR4PTGT
         XQVth8ixBfj/lHW4Q8blCe+aDNDUEOfQ7JOkfW+r2ZwO1lr8DXTPcq1qMWIdwwJs/GZQ
         yoHr4MDFlCbLhjUf8k47klnSRwx2RD/APVoEbUWmb6N/woSbvyOoD4DWO2Wl9KdbyTQ8
         FJm7ME6CO5lvDav47x2jC77m/j88uFhUp0OXbyCqV+PbWIufBrJP+lnYZ403db6yetRm
         JU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792804662; x=1793409462;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ukpmY9ch5lIIoawnCt4Ss+0SzKid7XBH5xM/xi/5vPs=;
        b=zFrZveCCimTcfCSyH0bpRQhErElS5dAI0mfagIiSky9RFxlNVeVb6NapNLQ+CKmpW/
         3K5gdNpjkVgnR5GT3FgjQ9974zb/w0lAkj9ik+DDFPOI+UQwubv4vgqXLFoZa7l04HBK
         5aJRSNyBxZfetYQShMpBR2eddHwGAqpP+k4Y9stcJYuhdxHv1clEqr8KnoccZWgzrVoe
         sDG1Xxw13O5QGNMxNvSJ1O6e5UnRdTJv2TjIdrGu+yyGlYRoV4qTKwx4E0O8m4i51vHR
         y/YGQJ9PXfK8bMJU4VEKovwWCzprDaZiFBAnR8b6HGHT2dSdISUCFd/TwD+u7bFUtuc4
         dXdQ==
X-Forwarded-Encrypted: i=1; AKwUvBxv0gkTJ61oMIlqSRMlNzI+5lYHWynETsknbB0+M8rTan3ZekmpGUyjfJMce9+L+4hDUW4geNY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSbGcEy/Fc5soCHwtPJhBWl4oYpGCB/5EDOBUxOUTWCuD1NLEd
	gnLybzeRnfs0Yngm+INH8NrqTCAf/f4dOEg7EaqoYVikMa6ney/rw1T0/3TAYH2WZdqRFiNePGF
	D75yIPbAvWll2ExHHexylk3Z0Bgr9/kk=
X-Gm-Gg: AYBFou3+Ftv0Z+e3Js5CqAlPt681L+Mg9WgaVrkWeqj53Bihj6R/zgTGqyI1s2qN0yv
	mrWV3GW2kQOyLhjiQNe4E4XaqOTZG1i4xouQgLF+YkJrQVmbbECWpyhS4P0QRfGNU9xZ7R3OGjP
	En4cU7jRn1evh9s0KO4eSzGnySVITYqzX4jpCZzbjkWg4yjPrd7AWPrpSH0xSrFIQlE5x2Zgieh
	vPKofsVAe4UB8WFcsAipX447S2b99Ni0B6hAB7n2KTEzJgEM0ISN4+0/fRg8cCx9aq5/ntLjbMV
	jzeO8jDO9g6I22CuNdlsf8EXScvDtUPtLF50T/mbEfQOvY9VLikqjTCEIJitp91VeGz+XEQ7kIj
	c67tiBdgeMY52hrjQPHNNQ+DtFhhsyZPFl3+cLFdudNtCL7IH9qq0BDpASX7p4aINAMWZw3jNAW
	u2SfY6Dd4dYLIT7jwF
X-Received: by 2002:a17:907:608e:b0:c46:8b87:c1f4 with SMTP id
 a640c23a62f3a-c46bddc4a4emr58034266b.20.1792804661557; Fri, 23 Oct 2026
 18:17:41 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020201537.2465655-1-prashantsengar25031@gmail.com>
 <20261020201716.94FAA1F000C9@smtp.kernel.org> <20261020152211.73eb8f98@kernel.org>
In-Reply-To: <20261020152211.73eb8f98@kernel.org>
From: Prashant Sengar <prashantsengar25031@gmail.com>
Date: Sat, 24 Oct 2026 06:47:29 +0530
X-Gm-Features: AclHuK-UhtLX4nQgYEXFsN0fsRm62C6TtcqwD-ZvA32RmYYMlNCoQto4p3wgZjQ
Message-ID: <CABW1sBnirfRyAReL4RZSUr_T=g2RHtaUv1oyAhFCDO4zr7xc7w@mail.gmail.com>
Subject: Re: [PATCH net v4] net: usb: lan78xx: avoid NULL PHY dereference in
 WoL setup
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

Sorry about that. I missed the 24-hour reposting rule, and the
automated warning ended up in my spam folder.

I should have checked the submission guidelines more carefully. I'll
make sure to follow the 24-hour rule for future revisions.

Thanks,
Prashant

On Wed, Oct 21, 2026 at 3:52=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 20 Oct 2026 20:17:16 +0000 (UTC) netdev-bot+pv@kernel.org wrote:
> > It looks like you reposted this series less than 24 hours after
> > the previous version. Please allow at least 24 hours between
> > versions so that reviewers across all time zones have a chance
> > to look at the previous version.
> >
> > See https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
>
> Is this email not reaching you?
> Do you need a personal reminder to follow the ML rules? :/
