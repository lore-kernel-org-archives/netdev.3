Received: from mail-yx2-f16.google.com (mail-yx2-f16.google.com [74.125.224.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEAB30C147
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 00:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604810; cv=pass; b=QMUwNAmLX2NzGw0voVqd0/6/XmVgvHt/6Zm4yX+FYxOmblt67t0CKcq6YuLTBjG3TdJmiuAw9wpMxuJ4hyDc3m9YKOFP3yVsuCuC98sQy3e1yP87HkRaX/XUXmorbMMA/CuECU9s6KET/eGmQM4P5FpPxOncxJUwJepmtf1M4jY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604810; c=relaxed/simple;
	bh=TSVKi+8VuQ9HAj+OFANA6kyNZpknRB6POVRr7Paq/fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fgc2OtMIy6/dESJLplwnrdfGKY/7/v3XbZ2Redm4GqEF4qpjejo1isyZWHz/wJ9IBuUxPOniMkJweCMcScuE4RTDA/oNYXFHtqUekLmR31mBmyk0eg5zEzR7lRVTkmJlLJipzsI3h+E+7NLCMgL/XiyChBskXK/xL0e3CCzl/Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7zbMB0u; arc=pass smtp.client-ip=74.125.224.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7zbMB0u"
Received: by mail-yx2-f16.google.com with SMTP id 956f58d0204a3-66e56a1fe83so245609d50.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 17:26:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789604805; cv=none;
        d=google.com; s=arc-20260327;
        b=YYlovGS619u18XHel1XYHduzhcotyPeYQ4gS67OfVpLU11o7OlFa4R/Vgwl4J0phlF
         aX9YCqbHzQp+A0/xfG/Bzm0YZNJNjWlxK8bE9+8bptlFRMJfEsOJ66dykCxwIunuCLgr
         zGNkqHlUI0ayTBPdWRVPBygO5CFwMttF/DhbzTkgW1v6Fy5lOmnmGNa1sSxv9v3vNO2E
         qY0BYhKy14hl2qADA9MOGPiZ24ptqWuLvnxxVN2eAqL6IFdSE+qyqrAd7cl4lchuwG2O
         UrV7g4BKYxSazhinTWBLBs6VK+tV68kQtlFsYj7XbtWFvH4xZTRf6vouhK/18xrOgc/U
         yhcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TSVKi+8VuQ9HAj+OFANA6kyNZpknRB6POVRr7Paq/fA=;
        fh=LypusJSeekforRXJXraEOeqnb8sk1mJUJ7FL1gWkS6A=;
        b=Zh3mI9xj+R3cRg45e1xYzIO/EoH3MpGd/hNJOKvwGJNG8i655/pcgpZNgD5qS+F1If
         tbU+6XKETl5DWcqdLSV6c8YAxnkituNNXhX8oX8vQh0mJv61ml/izC27Sr/SPLm4Gdzu
         aMs0Tm5S45J1lZ3JwklKL5b2WCN8fWb9D9XB4F2sIzf1K3KzBQ/aftw9MCJXRfEgtHyZ
         4NxMiikbfqZP2mJobtBWmeImB7triPbJQL1ghzGpCVwwFQ8je58WMdphDm48ERhA5ImC
         m7SLNV51xqJI0s04CzGUa5A3PkIU/vcdeC9TP3teY8STQ2vI1fcgek0DSBYyA7LU6OPF
         j2dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789604805; x=1790209605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TSVKi+8VuQ9HAj+OFANA6kyNZpknRB6POVRr7Paq/fA=;
        b=R7zbMB0ukOrSvm+sSvkK6bhpdf3R9H7NBii9uuxLZDvFXffAEMUy2HvZQA5d5aNWfH
         DZKXIUU0zO2MQ8c5WKPJE1XKVF9wbdzgOsEH6QE5asqErD7a5JoENZLx4CnTrgsvuzRr
         vcmZ8bKuexAuAp/fJiidb0W6zHP1eml9tWMRR0rn/rynjPM0qpYEJh5L+9sDtJH7JFSC
         /BLd1QJcfSXsd1xNLLBk3vLEWcxkOCqPxpVCX54SNCF6tEOlJ8VpyEBRyTsTd4G80SH9
         7XL1C5DKgvL9P3dZmz2VpvgEpzoV70a1v6mdIuwwH5zR/2pNu0pHoZfDhRJzJ1Tj89Ch
         0VbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789604805; x=1790209605;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TSVKi+8VuQ9HAj+OFANA6kyNZpknRB6POVRr7Paq/fA=;
        b=Qa7gnbhf/BKOqsuvZykJKHs6zuGqggnjC15Wx7s4qepGa06Gj5w7209/JIWuJXPHp0
         PQSQdjTNTYjv6raWb9aAB92ou5O+83rELVo3dXmSZuRhm4PyStqXiNLgqJDqicm2vaqL
         3jSLK+lqd5041JcXJCHtZTDdGwpr0c7JPZXSawqbu32OuRW5ZS24UmSoWwFvi27MaA2O
         dFFxj/b04QYuYUKHldTV9EzLQyQNEhF34qK5PmUavRXTzhbCt2Iod1l9LjTlAAM+qPm0
         tPYB81JNDgnZhszGoaMh1H6XfLADWdq06N02ferklhnU35VDAZMLVlbOXiFPnSXGnO3a
         TLhg==
X-Forwarded-Encrypted: i=1; AKwUvBy9QgNqxbbmuLbm3hveAC4snhvFGuwucUneQkJwHYPd57IUA6GHkichJ7YUHWxuGqUc3XT2HZE=@vger.kernel.org
X-Gm-Message-State: AFuF++nfPzDdmJlTgWtidVc3NxB4ZH4X8VUtFRNsMQlXFEilYXz6hn/p
	HTbjOYtqo+8zGibMW1OpeyjAk20tXjDa9X+d2FK6p5uZ40WHIUOtX62kV263jBwPJ3v3N+iaEXN
	ruYwjluRAONSYC4xbRKHihwsA9GwhIHI=
X-Gm-Gg: AYBFou1NVMgpTG/RLzBXKSvq85JfmfewdkpeCBnraWvYX2gN5LlK1JU+9aSFHDeXGvz
	bNxeEx82/vnxd8TYZBEjJT/o/vusyd0T9f5I9CXmrdzHp0bPs5w6+gsl8oFPwh5eiPOuJv3KfZJ
	DBRGlyFh5BVL+4DxaJamJBowJ7pCeehrbq9DWqRbHA9Gah09zPzJPmcPSIg3OWhOTpdE+Xsmw7E
	ih8qzhGp90MCuP+5I3psDU+YHcDp1Lskb0ypR93l58IRydW1ow5BH7q+2z2exFS46zAJUnOJFhT
	rdVGyafhbB6AZU1Zi5iu31/z2bcr5IaWi0zCmFwE2TWwVFDSl+g+LAz+lFKuicHHKKs=
X-Received: by 2002:a05:690e:1c08:b0:66f:c1be:3160 with SMTP id
 956f58d0204a3-6716329371cmr1669803d50.55.1789604804788; Wed, 16 Sep 2026
 17:26:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-psp-ktls-fix-v2-0-0eedc3b148ec@gmail.com> <20260915-psp-ktls-fix-v2-2-0eedc3b148ec@gmail.com>
In-Reply-To: <20260915-psp-ktls-fix-v2-2-0eedc3b148ec@gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 16 Sep 2026 20:26:03 -0400
X-Gm-Features: AcwNN1UJ2iJTwgwlT9180M0OEUFsX3crsB8-LF7eHYBnlBr14UoftWKUxJaOO4E
Message-ID: <CAF=yD-K5AJwgGEzmdAe=kwp0DuVX5pT=aM_hR9-hc-Jsv8L1Fg@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] selftests: drv-net: psp: test PSP and TCP ULP
 mutual exclusion
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 7:11=E2=80=AFPM Daniel Zahka <daniel.zahka@gmail.co=
m> wrote:
>
> Test both setting PSP after TLS ULP, and TLS ULP after PSP.
>
> Add CONFIG_TLS=3Dy to the drivers/net/config.
>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
