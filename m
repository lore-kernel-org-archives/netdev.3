Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706F7331200
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677491; cv=none; b=mB3o0+sYubt+L4mLRlGbrBfkEPwKeaQgldxEQFAEgrqZlCwVVrUlowFrdDYZveQhPGrFP07xjAsQHzexgyetuHFokrFEAC3Tn/Pg2SjJs5RcGqltSTOpBu9NDH5dtMbQtd+93iEKrv8xboraCInCMdOuMUCwzLLX3GYqDW1pCzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677491; c=relaxed/simple;
	bh=h383HKe73xPD5BfbROE+FJ0gKDZgGVTPazyVd10gOrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EjrVyED2QQbSU59r/qE5c+TEk4ktiQxK1eldT39DfJb3nR/ayf0mXo4kV8vrIpl9kCxmEB+IP3aCtC4W/wU8G5L5Eme7bLGW2TnJ9nD4yh2CsOw9bO2gXVrEnS4mGWbv2QOrKwBFfdCiogRN1NdOBueyTlrpIK1Jc0mf4krRFug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=UqzCLEnX; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="UqzCLEnX"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-128b9b7e3edso5160c88.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773677489; x=1774282289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/uUDNZw2WektSMX1w3e/CjBfHG1BTi7Ha9qQji9wag=;
        b=UqzCLEnXlzr8t4lj/W7T4wJnAFVC+P8Ua3QHkFB7hMhyT0MXdKPHTF8KUlxKVvYUac
         zDSGF6zH4sYLPHoh834VnfbsUYU57HJRJJrX2Vx+63WhKmWOjGeV6/bun+t8WVjL7GXJ
         LdXPn9YPYqtmVm2iCtK8EgAxAHRAQ+MhASYrPxUErXIv5mfEGHxZcvkkyGtzRtuK/MhX
         MxJMcP+aQPX8ZYtcBLHkBr7HFHJM/9pKMJmwGmAKUOx5WcIZLYO9U+BdaIUs91ECJsFE
         eVknvFTuF0t1d4bAB8jDrTQEVIKwbT7MLjpWK6B8gE9ETWlcyStuGncJOg7MsMe08PTW
         OKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773677489; x=1774282289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U/uUDNZw2WektSMX1w3e/CjBfHG1BTi7Ha9qQji9wag=;
        b=qcbkcWWh3bKjfZ2QZ2rDGaykNBE+y6dNkX9CJ4aM3bypIF0xSItjRwxQOipzRBPlt6
         hEVYsEaUzXeC3salUEKApfgrGws+9jHdbapB0/iafA6ECsRNv3P3mpJHSXiXm61dx1AP
         NyxaTjCU3dEr8rHXeojfr6GidpOOdbWAq3k1uw6s39e6f1Y6rDj1xGBHA+7RmIulJa6M
         iiN8NrYYnR1i3K1PYWfYFCQmMRyHMkZS9N8686b9IRWnPY2DejkRN4fAg/9DyG4DV06P
         5NzusUXhUssKTOgvcHI4bgQL9kN0ajdhqzoSMc09/ZSXw5mws1h4r4aWOMQrYPkEQlF0
         UCZg==
X-Forwarded-Encrypted: i=1; AJvYcCUGBzQbknu54X9W/dcHYfX7sZTwE7ZXTxeTWQ58ocm3tLzqR7cVYdMUHAj6Y/KaEkQDh9T+EvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/cUcHjTjusydU80zY52ZAWWzsoaHnyX0PgMyV7JWL1nAixnds
	9zOCPJAPaU0F8x7UkMS9n8XGjBzEwk2uy8VaPpvNXvTbKE55wyOHj3g84B1urNrIFEk=
X-Gm-Gg: ATEYQzz3Chnwj/4c5rJMoqq+6qJviGF5kXf/OIaJu2raCmfreG4Y/qmIYZt7328R/XC
	/rMybkLjjS2ENewCldjPPtqWUBiV/CJ+bPXw2mUd1sNMEpUfTv/qjlolNgXaINpW3R79h/nnw4x
	+GMfxuUolnC/Qz+bBWsP9Ec6ToKwjWGqILPv+ALOadJkCCGq0LZawEGDE4OZkhKdCB9n/nOb5oB
	zpMyaNPYN/GoX5eN4HuPPQppJucAknpG9d4Z4w60Z0fZnloQm5jGLdChNgVK75QKvU3AX0Vt5pk
	VN3BBNZwtZ+8oV5nDEpvNwQFktvzxlOIgbjYobn6NF4Y8mTFS1Tr9kSFglaLpBtN5mkFqVVZKYR
	RYfb0cV93QlC6B59lgfXXDNuu0wke6UxyCNh4xJfavSS3jrR0EkiTFTjFzEgqUWVMR9a3derj/n
	NYB8w+w21bLW/97srUhd4sb+cW3bbuIHYDl5Q=
X-Received: by 2002:a05:7022:4397:b0:123:2c98:f6af with SMTP id a92af1059eb24-128f3d3a77dmr7478509c88.14.1773677489206;
        Mon, 16 Mar 2026 09:11:29 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f6283873sm12779009c88.1.2026.03.16.09.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:11:29 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:11:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
 davem@davemloft.net, kuba@kernel.org, ntb@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ntb_netdev: add SPDX-License-Identifier tag
Message-ID: <20260316091125.640cb6b5@phoenix.local>
In-Reply-To: <20260315203345.13657-1-rayfraytech@gmail.com>
References: <20260315203345.13657-1-rayfraytech@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Mar 2026 21:33:45 +0100
Oskar Ray-Frayssinet <rayfraytech@gmail.com> wrote:

> Add missing SPDX-License-Identifier tag to reflect the dual
> GPL-2.0-only/BSD-3-Clause license of this file.
> 
> Signed-off-by: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
> ---

You could take off the boiler plate text if file has SPDX license tag
