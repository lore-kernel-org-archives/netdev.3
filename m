Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592EE30EF63
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 05:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776316910; cv=none; b=Pa6MxgSBDZLNavoRvXETmq5c0rHvcYFJ6SNWcmklQuT0r1pKu0yJvhTmfYu7NEU+ClmN/UqTEihRQ2M6g//Si3FmMXN8e+8NDCfXsJVIFdMMmMoa8cCCnSBoG5uc6Ph9kBhB+vS9f/+RdXNsYb9gErLw1ejl6riNra84vHRqbDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776316910; c=relaxed/simple;
	bh=Tr2QKNisroGorp/ou9jtcWDvHvRoKPd7mqCPcCjs6yQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject:
	 In-Reply-To:References; b=uidrWnK8Linhp39PORK9nexuBOxzOJVWqedjMl+g68udWWUQ3kFemhA5bgbtUbbGvzc/IJ/3eRK6/eNEr4X5AsN9uPBnNiMCCT7ibcfmHkBUVEovD6hlMnREwZWKRXrleSslnndnVUnxON0PdCXR8vHVnoVbvdOje8fe8dFN9S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USeQxGVn; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USeQxGVn"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cb3bae8d3eso668945885a.1
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 22:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776316908; x=1776921708; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tr2QKNisroGorp/ou9jtcWDvHvRoKPd7mqCPcCjs6yQ=;
        b=USeQxGVnl7gLOwYBAbgFaCVUs1fW9/eZjCACaMltpmiCH++/YWvrMiwriK7XViWORq
         cnW7Ael278lR8ur6pM+LrsCuHng4YYrhymqikkLN3Y1Plm2kGDn2nOCrty4cfUPd40jM
         LMvMggKYfp3mkLsRYbMjnYttK9cf2FH6cQ4ooZJsJ+AlsVJ5ISEF5sN3XnDOXv2P8Dux
         MoCmnL6GxBrBOdW2mbSQjVBKA+CRvO1ghTk/th+Ux9TiBqd3x4AHP8Phb9giYfKkoag+
         uVnNm9Ig7OAaklTIaXGHMAKEcSBWZvENWOF3GmbJb/orEhYJ68KBPCoQXgrcGWT+ZcL+
         vKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776316908; x=1776921708;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tr2QKNisroGorp/ou9jtcWDvHvRoKPd7mqCPcCjs6yQ=;
        b=fpF42ML9tFiOY+yTygrmIThMyYkyj0mmoo24DZL7IsJkwZM42NWRVCkbuDfFrW7H09
         PGNcMUKVgwGuX00B+vvJ+FLBzUrX9UiZjn+mtkVfd5VogxC+EKn/z7Mgbs9NRJRYdtKe
         ZCmHRhNLEHKnBRJui5hCmfoiIeJFEK0GYoQLKdtj4OCxFegVNtiTD0HwNQWYRaCvdfZz
         F7iAtR5ikovH3CRY98lm4W/4FsCDpEkaecuxcvGMNWjpPNj7EfJt1VE4g1M9nF1t+h//
         W3DEvN6yfdq1jkU0hxj6zwtKCCl8CTJvVocNmXv0mPdIxsAWOZhokRzb+uVm/OKVYLK9
         ubcQ==
X-Gm-Message-State: AOJu0YxduL+CpHw6FW2a8L7r3mogkF5y+ObuMgg3j/wwT5SKA7B99Pno
	3DqoUVueG5Vkl1fJf4bXmsnWOaIzr8OJt+c+lrgNdqki8UTh0ZrL7UGy
X-Gm-Gg: AeBDietVQceWovp+Jq7bMdAAxgsC39XC2HVjvVE9r0fHDOcLgwq8zDePkCyriKS6Fo0
	zt4zZgGHHjpJiar6gzy83bsTYiyte2S7cWaCzYUeOqgoF69rollTtLf6ovbLml8evUayF1M6N8Z
	KiakMO04Y+4qc3Jpp9cvjofYbkV/+b2m2Hc18z3qQrQbOFTofV2luMrxo7KsLnoDl498yBPQuvU
	AamN6FcTPqD3EkwSYsqAojnKzUycHtA4o0KeP8ewV+LUowBOmf+y6bsxWVY74V+QRoPBUD5+amJ
	Y1OxSAkiayuX8eoXkKzVKX/mtzAJCQ4EOerUIcsFNi8+ZOI/uE3JKtuIvAn4iW5VGZ4SOrlqZtb
	wSeR7qq/kPtJ61RLpRRyPGs2FiLwsxXavWvgSKiHy8NvVs7L1+9tbd8jCpHeuP4DcPoaOyeamMC
	aQuKCbM/xfB93aryIClR0tTKi4Tc6iYH+7YSljwIb+OaPM9PnwtaxRZyDFLG+KcgFLv1qBooY=
X-Received: by 2002:a05:620a:2804:b0:8cd:972d:334 with SMTP id af79cd13be357-8ddd0592044mr3357725285a.65.1776316908384;
        Wed, 15 Apr 2026 22:21:48 -0700 (PDT)
Received: from tdc4045031631.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4ef33af5dsm288477285a.16.2026.04.15.22.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 22:21:47 -0700 (PDT)
Message-ID: <69e071eb.050a0220.398573.29c1@mx.google.com>
Date: Wed, 15 Apr 2026 22:21:47 -0700 (PDT)
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, edumazet@google.com, davem@davemloft.net, pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] nfc: hci: fix out-of-bounds read in HCP header parsing
In-Reply-To: <20260415162641.GO772670@horms.kernel.org>
References: <177614425081.3600288.2536320552978506086@gmail.com> <20260415162641.GO772670@horms.kernel.org>

Apologies for the noise, fixed whitespace damage and sent v5.
