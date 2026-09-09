Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEEE38C427
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975992; cv=pass; b=JQSjG/u3aCIlfgzBhPpp7fNXGKQJbg7XUeBYVMQKB9blZb4bAHe/gg8PKi+aKlsiCSg7tKiM5biZ4/z+ieCOSfLcWo8gUlZg2ahHOux0BVoetxt4lObrGnCuvNRA6Q1ID+FvHLlDWMBgSKmIgg3JJdt28F0/8RUwhJ0ZL3hkCZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975992; c=relaxed/simple;
	bh=UJGGMp/OrSs3NS/+SU1nVzly047peJCMppV7Ba9pMto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZH/BVlRFEm343NKArshH07b88A5AseKKjdkK/vOh+vvatji3ijAS9/M4Kre8iq2AKfMCHpdYwzkqfGaytshdAji4zgWcz5flRMe6TDdS6TuxI8dUU+t+kxSSHI8VQUc7xUnEpgqQdfC0+f/QuIm/45UXwCNdJ9OcteWyF1Vfvik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuxHdGKf; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuxHdGKf"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c112aaaf04so383755b6e.1
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 10:46:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788975990; cv=none;
        d=google.com; s=arc-20260327;
        b=kn5euoSwl1OuMYG4j6JIO7wT/2i+I8wKfrw2u3ZGu1iroI3Y6137I/XZrEpuwDncHT
         nTSFmjCdMqTF2sLoONCdRhsjuTli1kQB8nkPoXYhCkJYIFVNm3yxtaI/haJm0xZvlljl
         Qie2aFBbQUCQaOAno+6KvtJh7lUvKC6FJRxz7fQ2+G8S7J8XgIX03cbivWYRB/Svzn+F
         8TG742Vyiujo2bJttIPkl1uzYweM+inwq4AK9ixY+7zoj2qunK8kfDmUddH1bWyqiTHO
         k6TUQEVWhPHIKZLVbBZMLgOVKA4nBNEf8EqFiGCWwlky70mfmvcz/vU+uYpeL/ZQWGlN
         /o3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EGxBHlYMfw2i6Wn1XBE9lhliUOi4k7OBEah5+qrJswM=;
        fh=OsYXKoY2sSKBhNTThW9kucESC7dyZwg253Kp+7pxyN4=;
        b=NV08gf99w2FTaFFL94u1D5rNr84lYlKOp7tnVYJCjvN6nxJ3GlWtQoIzRCbndR2yL4
         Rw3opz8NYDqh7T1I1Q2K/MBSZ0rhiqmS/EMdujvewIRMvja0pqYoGKIGRrsU4hJYQuBb
         PKLT/nuZBf9g0/6uarhOIdVPHjjmXrvbe+mSVocS2i44Mnxgf6cj8V9ZARmjGdMRHPkE
         uIWRNpxUyxjnYRbp1MvzUXmdYMgfdGJ3/si4iSexySmPjrHNK8BVG/OrmuVFZvZbaShO
         /I+RvhgHNLoc0Im65wB2yq2DY0S3+26OMi885zacQMZ5lGP+wNiDOYjIbpenwX2Ayjt3
         TEbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788975990; x=1789580790; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EGxBHlYMfw2i6Wn1XBE9lhliUOi4k7OBEah5+qrJswM=;
        b=EuxHdGKfpiC1H9knpgsuVeBfjytphq5Tx5oQKPUkVjTNoPTvafgdPMIeo+Uooh+te0
         GgYvtMTnoOw+g+lKXCNNxJ3hQ4oQbxyfhXpZA3OpcSc+a2Jj/gphz//+RPhZ+tv3VuWr
         Pz7q7Gnq5lFdDTQKhv0rBZrPCPXNzn9zBuuJ2l5C7GY15CsXpQ3ADTZfUrParQ873uAn
         QBwhcRrtd1IsTgPA8+XAX5n472zixsqSDZHbad/zSrUI1Sob7hGb7lJDziwon5Y9Gh9t
         hbxkf7YCJPM9qVqtmhaun5HpqHxHcDHW8rSbcNhYnYTZofjEadE1Oxg4VLU++xb7gDzC
         ScoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788975990; x=1789580790;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EGxBHlYMfw2i6Wn1XBE9lhliUOi4k7OBEah5+qrJswM=;
        b=pfhe7YC9HUyN8HfoPIduOZ63zNN00bc7sNjLkBaA4BZI7llj+okqGDuSIDkw4xFPGP
         WazDjS3fghHHruojKEF8slc2gU8DKES0qfB4HRGLZ6Xxs8rZnGo1/G8EEkC/ERzBTT3g
         y1KX8HU/M5v6OIgeItsHOD//uE2fx90TBkhJJ4JpRlWU1ZBHtpJyBkDTR9CjRqGNady7
         kKboZbn13I9fhnX+ZhXGt3Z2p7eEONBEpLQw9NidtKH+whXJYFEWCiEOaOcja9IBiyzJ
         y8vt7foHVN+lPbsrqpnuYLT2hkOG6g24CKG6sjsbkqLlaGu87GoOWenaAOik50EXEJNE
         rWBw==
X-Gm-Message-State: AFuF++kBvkmdfIGGgfe0Kjn51c/FFPbmk7v+RY5D9X49ScZX0xQ8vPn4
	pVHdkrWr/JFngKFsxKCtvFfGVLqB3yrmmQMUTP/6QmiETAUXMtGkavHWluzKcvaFSrkzzGOqaXD
	zXZYpSYrWzTdiwE9x6QlO9MvW5MUWrJY=
X-Gm-Gg: AYBFou0/Hxjyi8vGaX6/taZEN8+N+Mx8cTqSCpo/42kT6gQagXvz1VkGtXS/Mg3um+7
	vf5cRo9W5R3d7PSh2cWbewY5JxYen/BVllX8Mm9eqhnXXfYVS+u5YKaVfvpUywVchfBcWbLzO6D
	n0S9tjkfpAuQniYsB984NJR0GdIHe3xzeECXpUB509gpJ0i/iJXyhPe3YOSUYDHrZfi5g+etabS
	e9jqIbKbLcR26uTG53ESuEggftiFJa8l8ruZSoVwoe7EUQtjQuPwxAyNoUL4r3imPf3oj3+sZsg
	51PGGpgqdroiDbq4k8rK1c/ir/uWw7oPzK6fYZbi0SeYoGFR5rjkGe3XVosKHXvE4PVhCKG6pxi
	lQNsmTomVi2d3
X-Received: by 2002:a05:6820:2912:b0:6b3:b9d1:f629 with SMTP id
 006d021491bc7-6bee5e98160mr2823187eaf.31.1788975987613; Wed, 09 Sep 2026
 10:46:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906131414.2683362-6-mmyangfl@gmail.com> <178896697703.219967.8447526738608779891@kernel.org>
In-Reply-To: <178896697703.219967.8447526738608779891@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Thu, 10 Sep 2026 01:45:49 +0800
X-Gm-Features: AcwNN1VxSFEObAOlS0oWuqxHPTQpRA1FtSHwEXKSDmt_D-rjyBcp-cftfMoT6sc
Message-ID: <CAAXyoMM_uqu8z0jzTbNGGbOBW5UX3PGzJ-Tz3OZmyQxeYxTs0Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/6] net: dsa: motorcomm: Fix MIB synchronization
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 11:16=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:

> [Severity: Medium]
> Should this carry a Fixes: tag?  The unsynchronized 64-bit MIB accessors
> and .get_stats64() came in with 186623f4aa724c ("net: dsa: yt921x: Add
> support for Motorcomm YT921x"), so this is a fix to already-merged driver
> code.
>
> Related to that, the fix does not look self-contained: the counter type
> conversion lives in the preceding patch "net: dsa: motorcomm: Use
> u64_stats_t for MIB stats", whose changelog says "u64_stats_sync will be
> equipped in the next commit", and this commit also builds on "Rename MIB
> stuffs", "Split MIB buffers" and "Split MIB module".
>
> Since neither commit alone closes the tearing window, how would a stable
> backport of this fix be done without pulling in the whole refactor series=
?

This is a low-risk issue and does not affect control paths. Also it
would be quite impossible to backport it since the whole series is to
fix this and it would require major refactor on the struct.
