Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792788429;
	b=Cd4VFurFWZHMXUygVPg8RPk7Mfh/qr5kJ7bvD1K74BW+pMI6xnGyEpzVCoDT0z7uAnA5
	 bne0M9vv0gSwmsbkz4Af3R4pFihWTebGonZ7HBPo/L5Ef7wtWdB4Qie6M9oQEYbXTRLcG
	 WSfayxxdd/C01O64a5zEjgMlW/g9D9uDQd01t+hRfvvncEbHfj2rSNcWwdQopgSMddOSw
	 DRaoJwxFLbuCvh/NJQhDGVWpz1cL7o4/f/gc6gzscKHCwB50sJ1afrqBcgvkzA/YJJHYx
	 ntM+o0hC+2FgKmLtMsALOxZZ5nJSUx6zp7hZWAT3xe0ZdPROGaDS/ziMYnW8xiINwzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792788429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TCEbxm8avzTummi3Y3lCnYO6mye35k+RSerUFk+JTQ0=;
	b=wfIPgBh5dBRtEOfZ1T8lqMzs13/ohbox0z81IgVYHL/gmlGBTSXWWam5S7N2bFdFjOxc
	 rdsDgz5iP9NRCGPU5jpxCiJJ+yhYBszt62j8yjvMRaFkKcFcjqUvJfImU6x9jIpoFmCcU
	 thicXGyelcoatLum03fMmwxaLTrwPtB6EUCYocejPetbWeXfnk2cGCbq2McDzJopFQknK
	 QA89NOumopZHeF5KhpXzcIpYWmFYWGOJjb4JsPGglePtyW7Oz48uPJiqPeYxjDYl0bIOE
	 ZGoByKlAvl0W2crSnuGx27rxeJiJFo2XO0MkI2pd5HFY1MTdOs5qPkEd/IlYkidPAdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oyY+LF3R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1639606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 20:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1639606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oyY+LF3R
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4322d310e7so195419766b.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 13:47:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792788426; cv=none;
        d=google.com; s=arc-20260327;
        b=ifcro6kg0CYlrGbD1WOEkfVwdDW16ZMRCd1aBMPAz4WJjA6de3g/YvDK0ZaT0nuWFj
         5bYi4T8XUvto372bCQ37Sr9t7itI/yWkVsOE6u8j2LrelygJFAp8rdftsZyka9X97Csf
         TSx79+ldsnU5w5KvWj6mIdbyc3A7sPOknU7SNT76NaIdaweVoo/cdN8PzuU+sKEfi6ny
         4xQXQq68+IuGMe06/4m3srcnoF4K1V1tCGPjgBSp1pwV7H2eOyz1H09n+3rgBnsIh8Kz
         VU8RZ8vjglBjokKX2NFL2PnJV0hSYrcSYe/fQ/mCQHqI7ZcU/7XztZJoNpmOQYzL2ngg
         vPYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TCEbxm8avzTummi3Y3lCnYO6mye35k+RSerUFk+JTQ0=;
        fh=+jdvrnWoETLz2fwWZq35EzYOm7QEXUmQY4MDvC6Ez+Q=;
        b=qEvpwCAwsXKcYMWYNf4YtffdduBqVpKMKbJEWE2VXsx4FvgVEpQUc0vEMJjtpwwNHF
         VZsyCodHFIfW+863u9Y5bBkZhA4dOFANbegaIY78ij217QH5DwoaGMEKe0OSHUlmXdLM
         KdWmmYG/gAg5oEohoCUl5L4Tn/w88+gD0EMVfzfuVXRwcBLMc21ZbrPHqRu2dP2lxpzn
         velpctwKDat3nS5dGZFc4mYmvYfSiY+mN3D1dY2I1jKZx1ASWe2Xq5gTkXTfdpMXVeO2
         RERGuPqb6XGGOumB5sR+l1xOCbgw6qfKg0ziYQ1BRi2v6Zv4oaAECLofYJ1/yUQRhMzj
         ySDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792788426; x=1793393226; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TCEbxm8avzTummi3Y3lCnYO6mye35k+RSerUFk+JTQ0=;
        b=oyY+LF3RBLKVUchgpkrZgHuXUdI3UhZ6sDH8n5vdQRyhJ702pqsWIZlC0Zo1JYcBqy
         zWYIKFKmIfbmDKAwvihtYud0XXU0ugl+GgJSFXWFPMtauTSwJHYCiZNXt+SXBw3BD7m6
         LThfv5zU3BkBH+tAC8OYLJgqi0fsp0izHfnUYufYTwFrw2nhltZ9d9iPBvFqRg89UYQu
         Q9zKKfJRFoonqequfrUZBvFMJhMgii0wwfcjvh5bKPTN6COi0g9KjksenOOXtWtCZH7j
         EMs7vlFV/J5VdEMlJXd5fUn8JNSg1I62nV9Jyov3HqZB2qy+f/AIzsjE1eyApoA8Fbu9
         I/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792788426; x=1793393226;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TCEbxm8avzTummi3Y3lCnYO6mye35k+RSerUFk+JTQ0=;
        b=pF2qwguhjPxNKz3t+kNR2kwxYXeyqkIq2I2GR36v8uxVwkErz2f4o6qT0WnyyLn8Vj
         QkJTyARwVoX68henwyIpfK+8+vHsv9jsIGVtARKeBxL4/uxxTeBMJorApHeuso0GeXFA
         hC9p0ipW2IO69Q5OZnpcsQfcGhHZXB3ibVN3wu+6wPMd9hI/+jOb936PiO4tvgTahEXp
         blqYLPd7tGqVaBDMVraGfckP2Cl2UgW9FKRyqK4JW1wShYwRX+hIiU05UF43tQWpXPlz
         u7hcyfqUtjV7pKP75itr9ODAkvIfF+jyq5fdqM895sIy9S6ba+pi3gxbS1430B4n8EHm
         2uHA==
X-Forwarded-Encrypted: i=1; AKwUvBxLuf/5ntWD95dVKx6/HI/GJkTGs6XwxTWDxqBF81WB7j3Qcf7xPfI9pHvvlVZDr2Y0HwA1JWY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJktHvmEhN7gN9A4lOu/SUUY0f3WwoCObnZAXAFw50EcjvK+dfR
	F5cXimV8jGstK6PC9/bZfGOxa334TTWsoWrnqxLBfrzO/UMfTEnr0g/n5PVTBbfrEzpGQNZq8Ii
	hcbhd3t3JxYaha+AR3rC/vkofsY9YGJU=
X-Gm-Gg: AYBFou0OSx3AfSR+t94V4RyeYtdfytJOxndQnGIukGLwejQKYjnBdLHpQdK5FdOpcQn
	P0FP4QoS1tFrJgRWduTEZL3pfMd4sSVvn4gXD0d93l4HoBpI5T1Aq/sYVNsnBz5/kAuRGVJUHop
	yA4YKgzTOyXbFcTnWyWHU7bB0VpK1vB6unfa21/TuMgNq1TnZNNwD7UXj/SxwqR8BJqQKlnW/Ed
	6jZCjJ66WL0t4B8YKypaQBQqK8OLvopWkQqMNihOHL2UHOxBkjSURN3Hkcl5fiamwMRNq5ZoE9U
	iXUQ6qOjGvSTTEblNUXojgpuw+ZCnLInTOTi/3L+PgAcibbgsgjSJlBZvURvpwKEaaxVUGRvtE1
	Cx1uy60hufXmtyEsDRkGgdORUzCct8Sd73mvaCOFpcYfr8y629lIuPySJ8iNI2Wl6yboawFkrZq
	vvp34z5LI/S1wBVeSgFvInYM1fkK3hbY2NQppe1Vwz8k22e+3olIp1648OJzniff9vGlTDdQvvw
	g2MPM99QOIWfBOZV7tDr2ZxznPcx8Puzz/RMLtofGQqWyD9GQ==
X-Received: by 2002:a17:907:a0c9:b0:c1c:4a80:30c4 with SMTP id
 a640c23a62f3a-c46bddf651cmr6811166b.11.1792788425687; Fri, 23 Oct 2026
 13:47:05 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023005313.3946390-1-rosenp@gmail.com> <179271707120.3327.4775409276963055481@kernel.org>
 <CAKxU2N-_Th-ksPst_1KR3W1nYWoZpWR2Sjfo=RWroot5A1RR8w@mail.gmail.com>
 <20261023123637.1aba3995@kernel.org> <bbc66ce1-8d8d-4d35-9314-98fe14082690@broadcom.com>
In-Reply-To: <bbc66ce1-8d8d-4d35-9314-98fe14082690@broadcom.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 23 Oct 2026 13:46:54 -0700
X-Gm-Features: AclHuK-ivruJl9X9jCViXiK5EZAfSDg6147raVZhkKBY9-G9io85x7I6pMGwWMo
Message-ID: <CAKxU2N-aNWtZUc0bkkc5H9mFWUn7RDti_ZzX4UHXhNyPPq3s8g@mail.gmail.com>
Subject: Re: [PATCH net] net: bgmac: fix oversized RX frame check
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Felix Fietkau <nbd@openwrt.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 1:08=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 10/23/26 12:36, 'Jakub Kicinski' via BCM-KERNEL-FEEDBACK-LIST,PDL wrot=
e:
> > On Thu, 22 Oct 2026 18:00:53 -0700 Rosen Penev wrote:
> >>>   - How the issue was discovered, e.g. hit in production, hit during
> >>>     development, syzbot report, manual code inspection, LLM or static
> >>>     analysis tool scan.
> >> I added Suggested-by in the commit. LLM only used for the description.
> >
> > Suggested by is for suggestion of how to write the code,
> > if Florian reported it appropriate tag is Reported-by
>
> This was a suggestion, so I think it is appropriately being used here.
So do I apply both tags?
> --
> Florian
