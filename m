Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD5A3803D0
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789570907; cv=none; b=USjWnQ5La7ci2QhQTxhvIm6S2OUEGlNcILgxJwokzeRuHmSU6uyZODyB36nN3ZZ04aeRrDPsObMe9JR/X4u/8aSnM88oF0Qka2D0ZNo8t6T7UeywdZwhCVHGPhH1lsjoVDD3JADLaxw6W9y7tB3cfYjci3Y2hYSdpDKC7BCNBiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789570907; c=relaxed/simple;
	bh=yNOZpHwujwy+2/sqpvO+7Bg+1RUIRyAvHnR1tRJn9BI=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:Subject:Content-Type; b=lFOO7v40/MPzum3ePM+NoCI0P2Uj8ieyR3MHQlCppoopsZtL57B3rPZgEcNNTs+8M9nmaj4G4PDmqfcXElx3glZcOkjl+JVHstJ6sCMCgZo50w/r8mAbNAgNLk4MJOE69fe0MScHtHijU13vgYsoasfxq25/Tt+mT4E0GDnZwUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ei+Zsv/7; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ei+Zsv/7"
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-39e249c766bso246647a91.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 08:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789570906; x=1790175706; darn=vger.kernel.org;
        h=content-type:subject:in-reply-to:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yNOZpHwujwy+2/sqpvO+7Bg+1RUIRyAvHnR1tRJn9BI=;
        b=ei+Zsv/7Pqx+OlxaMuu8hf4LPMD0shPFOxl1qstWuYs/PM1YFeFutVqOuvzhAh9x2J
         9L0lzEPCMyEddGawzWCv/tye6t/AYkaCqU6fPliQEKSf6HrL17YesyIMZyCcleQuhZoD
         BHh0YpsXgXP+yi6VfZkMXV55BWQpQ5bQ7unBm9YVl1BZh3WPQC/5xIpj5kM17BySom4n
         ku0jL/TPJC22mJnBxmYPmkdoxuTlg0DlBD3fvlDv6Scher9R1MMa5TP5T/U7Cess5dOT
         f8TZjCmfsQdaPFJ1cM6jYcBB63iSdE0hP1vxkVS67A1C9G/Xx5Sv7R48WHB8k/CJKzrG
         SxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789570906; x=1790175706;
        h=content-type:subject:in-reply-to:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yNOZpHwujwy+2/sqpvO+7Bg+1RUIRyAvHnR1tRJn9BI=;
        b=flk8eActonThKHdoNB3eLVUS/rvPECwDvl+wx0Bljc9aCgCwv/spLpDO/X2UZrflUi
         BVGDy9w47U5bFA38Dx8lDGIlK7gc4MIEonC3BuJDwX3wZLQ61M6F/aiTuhjSaPedkJG8
         5spVPZkkd2Z4SjOHDyzbvF2KTiuIaX0oBOLnKYiMC5G/x/+lSjWi0pkmHtGYgKNIF6WO
         JAblkmW41HilkoDcmHu90kFkbClaxBVatveavRtTkKgbt41b5w2LhtEtrLY2+Iuja4SF
         vhcteFdfENW3FOGW/PTrMqVBjeGvA/jUwH/XKdgDrbXHD9q5Ycf60HQxfuxkwHPn28ZG
         WrqA==
X-Gm-Message-State: AFuF++nXpKp+m5EGVdAdXavCXVco5jut3Ej3QVkqvN58dGkD1uDOWnqq
	PUd2k11+txW/1q1CIZPFTugVnzSEaqVKyDtdLhR4n/3JLydraVRf0icR
X-Gm-Gg: AYBFou0OKYdfsBDOaztbLTvC9YdKqEjs2LJmw0cc8z3HNZ/AMl6OCBZGO06frkCudrp
	DzuW4wIQncm6sYKYD7f5COLjzY3tLaMz6dY/zAV/mv3TZNb2ieOXrfza8+AQbdugcax2Z0pklTh
	R4nW3515FjlfrkC7WXguRWPdwuevvWQenWu9wHxSIzcthx9qBso2EVjp1yRQAdnNHP4YAi2RoDh
	rW2hY21axUisLOkB+4M3qPtCKnSVOcYh72oUf7jmNTRAZ0gEQ60tjIjZxOB0XTfv6PZU5dxkkeN
	8mcPTHKN0eShq5eIzl8Ao3s6csJh+J3IWmo8BD8BOAX7D7mhZY4kfCYbxChQxw55cwsVA/CWIpj
	MFpTkpi78twfo3aacbDBQGoQg/+BkJJTcEvNKLMabSKZJCNOlvWZg5OCNOE0rX+N7HRBGXoL4DP
	uVxHc7JIJ7waazF0iZ5gPxNMRd76N6CLN49XbnO4r7CR2bY8TKUQouJprhWG+g+U9p
X-Received: by 2002:a05:6a20:3d8d:b0:3cc:eea9:f757 with SMTP id adf61e73a8af0-3dd5f5de790mr7607051637.16.1789570905798;
        Wed, 16 Sep 2026 08:01:45 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50ab54e26sm1830321a12.5.2026.09.16.08.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 08:01:45 -0700 (PDT)
Date: Wed, 16 Sep 2026 08:01:44 -0700
Message-ID: <e1f0afec333802ddf74ca6edd325d37a@gmail.com>
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me,
 bobbyeshleman@meta.com, linux-kernel@vger.kernel.org
In-Reply-To:
 <CAHS8izOSaXtZy98UB2ye4-+59JujNb+SyBp+EO=YjnDvYLr85A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: devmem: batch net_iov allocations
 into the page_pool cache
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

> Nulling is probably unnecessary?

Yeah, not needed technically, let me drop.
