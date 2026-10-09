Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC6E3358B9
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 02:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791511825; cv=pass; b=ig35Ytz7JpOmR4dt4P2OwzsECtF9LihLvdAv2HCz8xrYBukx6aoAY+13uiY7Kyu7JetUjlskJqBDfsxcUgwJfDs+MN30vUgWAFm64awIPQHIL0yLz70k/cNCm3bgucaye5xZwBlXfhb2nb/zAvn1BtpAq3HD41zQn89tUOdlD30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791511825; c=relaxed/simple;
	bh=LEVAMfzTnIrU83A9+0hwO+Thr1TbDzEvww7s5Ai+Z6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2erCg1eENVKvnb+SaBBgIXP3fWBiOnp4FvxmvYvzFHbJpbNcwpexPyL3zuj2ay910xAhsQRQVK93OcQKM6zpIud4uw7jSI+JZ/NxMc6qLH2APw24d6y7NZ8Nh5FNFdxFnFJxnOCxDxazWdIsKtzIF54ORz+F86GJqnNDaq70yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNgct5au; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNgct5au"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2e38b61974so29748366b.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 19:10:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791511822; cv=none;
        d=google.com; s=arc-20260327;
        b=L5kv+xvcOHXj1PCx158idbhS4WnSSM5UzyuPe9sfUk9iA/w8Riecbjx8eahVmbUTf9
         RRpZzAJiUSuQl4fORVnw9GYnonaghGUkFCA42iJY3CjCa5V1wVvXh/yEnteZt3wYmBlH
         5rT5bhdM+cu/q9RTKj8zF+ilaDlxJyEbZtAHiSksUixHc9ZyL0y5PTzkX1xKsVrep52Q
         tWXzC29aTK4tOLrdplcybu6UUG4LKovPWsw1loPsKLsxbQMD21+3GW18SpF1Ydm5Gedp
         zGxoM7hfxQULkd6qdU86uOf1Jd0+MITP+3ZhYys2UHaNueZyO3rgCZbO9/g3bF0AozjK
         FguQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yCrQzglEO/A7J/yCrkORnHOdyV+MsWSTQsRZD0EiG0E=;
        fh=IiiSQFeAh91X3KT37g3ug+01frx+2tkzoIzWaGp5blU=;
        b=bjB2Kl7BdEX7dYJQGlYyw9TuoNgfuDwACA5VKES14qOjuyudpcFcwmEw1rFT8+4puH
         vpORd4e7m0fvZwktY0RN7i/pWc/kT+9u5rSjKpyNi3NJNMoYXX3V2/HMIB51BviTJztN
         KWOuexVGGF+ZYL4VLqPn7msySW/U5KweRAB22uSF5LwONGrvRFn57TAbXd3bCuOnwSaq
         5RFJp+AvgJTTe2/96NdJ6D3QIX436/r/MlFACZOt1NSxN9Hyl97VgHubpJ7PQ/T5eQIw
         WXSCErwC3+boyT1O+LgJk1kFHv6cT71ZdiTbzl3k6xIfDGS92St9WLbwAtlH+XnLyTdb
         jFeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791511822; x=1792116622; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yCrQzglEO/A7J/yCrkORnHOdyV+MsWSTQsRZD0EiG0E=;
        b=kNgct5au5wCwKWLNtoBCPHGbAjnHrJRqGe9RaVgWX0H+K+I1dJUsbZMsGwDLYf4Yvk
         0Xel3s/XBgDmE+qKpHDtixRGjkmk77c0a4sYu66YcmzaLZg2HbNG/uHEPQfbADs8JvHv
         uP5fpvXLiWtfRfm5k4UHoJQ/vyIgZkWQ6rh6fwRM8+vzqVJlaws68xsX11XwEFWdXAXp
         mFVOgIVaPYZ987YgOlFNAZcd5ZAXqDhLakDX53wLRwlVF8JeRm4Uz3NjZRg88qMvqjJr
         UdxA30mu1EdSR/RrAn1wHiIIH044Xj3p9cyyH1eI9Ccph9gn5cetQkyD/17A0Ib4GRJL
         gXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791511822; x=1792116622;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yCrQzglEO/A7J/yCrkORnHOdyV+MsWSTQsRZD0EiG0E=;
        b=tWZMZnJpYV5O6Zmdvnh0M1c/MzT3LcvERCgHwd32wjxOh0AzFl7YR65k5BB7f3dnEB
         o8OJQ3c/bw4xI0APf1Aq7e1Z++SkeQ7MTvMYWnTwLTQOgogU8Ie/7Qx6PdPm9Y0G/JYQ
         Ib+iSB24jZjCQBbfgczJ7zGBQqJ8ZTeI8BleR5i12aYPBELu8tvslcJOh5GIKoEQdwsO
         rIEReowHKJlkyAEo+ee+RG7f1zSYddLbkB/VN4vaTKe0SOTStQ9k+PeoGUbCAsXFC6Ol
         C++7LMu1nHXOkRXNswClYT2zNR7weM8PZMytk0VWnOT3/MIQXc/mVS7LfVXajITV1eHl
         T8rA==
X-Forwarded-Encrypted: i=1; AKwUvBxtkoLbnesngVlY8tYWmj5fHpU5tJAcOktJuutGUraD4lFr0rcgJBkERfTSEyyD2x2XlWFHBwM=@vger.kernel.org
X-Gm-Message-State: AFuF++kt90uNY/+itQl3o/7WQjIbkvHz7V5znZ6Dn2cB6WyIuKLnFb3i
	adagEC0DEKC8oroek2xJoD+NYETaXKZ99FayN18UdNoG8Ov3yOd/pt9LQuX/i25/hHNSnnDK0i5
	NnqCnnsGdDcqxiANoPg8TpTeI0g5B6xY=
X-Gm-Gg: AYBFou2VcQ2S6p0bFY4kJGPmqoLTfY2WKY/uUIL7cBaPfTtEAWuGySbGzeDpxALtRDL
	UU8NPJEKeiFBtAAccHG1hh8F9QUVRtShOV6Y9b29py1MH+s4Sa6mrrZ8L6QYXwrr0wzQuM+cTUP
	HqTdMJA8G2V+Nr8yZFQNxkNmBHRC+PAyOfy9pVo/11hlptuhyZRnpuu78sFuagSXXOzYmEWf3yj
	uaGKdqREhtpa99Lr1zO1q0KG7wiwwES2wr8aKKpVfZxmOZr5LYVqSQxz6U7KqihNuM/jExFAEyS
	wVDZmvhUgmwEZdMsQ3kvGOmMikOwTjZJCxqBGvjv0hgt31xtx+1loFhDaF/DW53oA/bwBKmXHqQ
	EaaMJORkOjA==
X-Received: by 2002:a17:907:d516:b0:c2e:39bd:d6bb with SMTP id
 a640c23a62f3a-c31a9a09d51mr46781466b.1.1791511821833; Thu, 08 Oct 2026
 19:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002173844.3537111-1-nicoyip.dev@gmail.com>
 <179096305349.1402591.6316561110428507255@kernel.org> <20261008164917.384b8e96@kernel.org>
In-Reply-To: <20261008164917.384b8e96@kernel.org>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Fri, 9 Oct 2026 10:10:09 +0800
X-Gm-Features: AclHuK_MKZrYKC0pZ5TgunLeFOJeDzBazt2GlOkbI3BRXa-QDM_6-DuNBaLWb9c
Message-ID: <CAAo+4rV243Tj28op=Pos81-g-txz59Tb-a6CP-6rbngN=rKU1Q@mail.gmail.com>
Subject: Re: [PATCH net v4] net: pin protocol module before inet socket allocation
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-bot+sinfo@kernel.org, davem@davemloft.net, edumazet@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 7:49=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 02 Oct 2026 17:44:13 +0000 netdev-bot+sinfo@kernel.org wrote:
> > This is an automated message. This series looks like a fix, but its
> > commit messages seem to be missing some information:
> >
> >  - How the issue was discovered, e.g. hit in production, hit during
> >    development, syzbot report, manual code inspection, LLM or static
> >    analysis tool scan.
>
> You have to answer the bot's question.

An LLM-based scan of the networking source initially identified the
issue, I then reproduced it with l2tp_ip by racing socket (AF_INET,
SOCK_DGRAM, IPPROTO_L2TP) against module unload on a KASAN-enabled
kernel on QEMU.

The reproduction used a temporary 50 ms delay between reading
prot->slab and calling kmem_cache_alloc() to widen the reported window
proto_unregister() destroyed the same cache before the allocation used
it.

Best regards,
Chengfeng
