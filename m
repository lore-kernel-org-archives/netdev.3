Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14154400DE8
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219169; cv=none; b=VFsIFS0MOb9z19g6ZvgZK3fWolg0BbhkzEyAPDL/cXq8ERXqd3Nfi9aFNAk0a3zIZbHZGmhsNMog0Ln+9kJnssXO47rdZsGrpSeyG4k1/Bb7IIgiUEu+oW2UoR65Y7drAfqW6Ku2CjnzLLAJKrjqvYKvH3nNhSE6POXwux42aaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219169; c=relaxed/simple;
	bh=JQ1eSqPNn1+LXMfAcmrxFR8Ikxj1rdRahShY+md6ufQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ceo6sEo/RjZ4ygYeYL5uM2qBNzoDycIuw4Wuus+8+ovksDi1PUkxFVVjZbFlLJWTDzRcJPiXk+RUlTNcZuPWA9gP1hCNLCEb508Sfx2bFIInaPlQJf1rN1PTyPlCEyVlHyv1igNxAEBzpvJtUqBIr+qUh20G6ceuUWsMj962POk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KGx356h6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s9VLAruA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGx356h6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s9VLAruA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787219153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W/M3FX/PzOuwTESGDEuq1PP0caDeEGuYGirIJsUALrk=;
	b=KGx356h6xWWx/1EIhoFu92zC8AQh7QDvMQx86kzRkEOGrbH7huf2rb7o+9zVEuk2kfQn6C
	hovHLu5jSg0LxoRudwMB6N6fC7C4bVJWMH44L5f+Rj9bQYXSmpRAhlXR3D4rTTjRVz0q9z
	1j4kvp9zx1mkO0jzSE5sdOSnsWy2tSI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-8J0SACNyNWqebhIj5AxjkQ-1; Thu, 20 Aug 2026 05:45:51 -0400
X-MC-Unique: 8J0SACNyNWqebhIj5AxjkQ-1
X-Mimecast-MFC-AGG-ID: 8J0SACNyNWqebhIj5AxjkQ_1787219150
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4994cf6cdb9so14091815e9.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 02:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787219150; x=1787823950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W/M3FX/PzOuwTESGDEuq1PP0caDeEGuYGirIJsUALrk=;
        b=s9VLAruA29lMMqL7jgxOBTX5rGmnkShVTMIOIEfuM7s2cVGdDZk77YxnD0Fq9UOsaN
         x39TyTUwT9Nz7DGu8iVt+HW1Py0ixV4dZywIt/8jRnTPnkiLGO345nWAAcamVv02Gvdu
         VqA5CLDpXPwcrf5HKzpLSKX/K6KLAtiFKPAJsk4yU0V5IizF2A7fLNI+/FKGUG8YUI2W
         J+XMu8ytxfmkqc3lb3yLLqoJ7/SxP4x63rzknaeyfemC4WZa6VDpFj6stUs1BlMgS/N1
         81rHrbBp+AuU7FxsEYqqYAseB/4sXcssTiH+20Xb+Rh6tV1SMTfcgdZFZ0sFNB/RtHbX
         QGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787219150; x=1787823950;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W/M3FX/PzOuwTESGDEuq1PP0caDeEGuYGirIJsUALrk=;
        b=FmX//mMYnu4Tdzzy0Y+dRpyNKdFUL8Zjca4Lijbf763fkXnydBjanQjIKGdJaeTh3d
         MsHpYeWPavE+2VPD9WL8LkMX3gJA6vIHi7dnyAjcD0LiC0A4w7EuKBaGTre7+GHKyarh
         bBwOyp455Rj6G/AQJo3x05Psu5VYBXjaiw4tpfdLw8tD246l0KhWieyUv2T56IF2YK39
         7LonTKX6Nrt2VD/uANWtKc5GDzGQlKoPWrdSCQDM+jkxHq2tePnLg1P6EPBT9hBPacUG
         6YCIoA6cWKNBCpoLmjgJi/KfBhv3Oef3rXjvqTtZLqxYeijzopBkOy1RO4KlzRxRaCio
         Okdg==
X-Forwarded-Encrypted: i=1; AHgh+RpH2rdVoXe0NRUs1zf4a2gAzp4a2S/dAA92AFSoGomEtZAI77Tjl/5Un5bMtKnvf5QxerU0UBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJx1THCk7S2iIa5hHBQtCzK3LaLLQvXyfy1Koypu2GkaOla10S
	yMrLVJOoNQJaGfPvtS78QWz/1wK9xZLCv3/zXZlvF/v4F86sZoCDMBrge3D3IyQLC17YbMPKZ5v
	cvQCd3LLM2oceKEuv82fDU2s5sBYfyyt8ISS3lEjGk7yLflrQrMltIZ8/Ew==
X-Gm-Gg: AR+sD13ztba4CpL6p1SL6aO1RRPnGgfCUDjffsoTHsnwFhsl+bVdzaLaCjdGKRMU6Rs
	Bd3LlWIYHjj7x55IARlA5Q1spELPPIpjZ1oWed/VH2KMGkArWsRLDgMM5VSMUStg13+u7o3n6ti
	r7OXe2zmIjqUQhpcVXQq8ROSdVv1wyqrgLeIMaNxkn7MIQWqul7XFIcHRZJLLjUIWahSe7Zsbtm
	RT4oL4oLRnHhUUcHpxwMhrnddBqayF4rACQH/NB5E2eSW/WRgAZtMzSPmuQ69KIMaeuCZ5Q2Rn7
	94EMmz61LrHf+hJ4zeNbiFm3On7PgpX+islOEWihksPtjphXCHqD0axMm0g0JKyQsltMeSlItmh
	HfUOwtWDgF1zZhjfp+JqsiRMIA2MFDibp0X9bHaR9GNgcOY6ANBH0VuZEN1aNloQVRWESepbwuj
	E=
X-Received: by 2002:a05:600c:5294:b0:492:4e09:9fc1 with SMTP id 5b1f17b1804b1-499aa1f5413mr211338305e9.15.1787219150328;
        Thu, 20 Aug 2026 02:45:50 -0700 (PDT)
X-Received: by 2002:a05:600c:5294:b0:492:4e09:9fc1 with SMTP id 5b1f17b1804b1-499aa1f5413mr211337565e9.15.1787219149869;
        Thu, 20 Aug 2026 02:45:49 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa074740sm140264125e9.7.2026.08.20.02.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 02:45:49 -0700 (PDT)
Message-ID: <2c4045e5-6859-4e77-855d-90bcdd632415@redhat.com>
Date: Thu, 20 Aug 2026 11:45:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 net-next 0/3] Implement PTP support in netdevsim
To: Maciek Machnikowski <maciek@machnikowski.net>, netdev@vger.kernel.org
Cc: kuba@kernel.org, richardcochran@gmail.com, milena.olech@intel.com,
 willemdebruijn.kernel@gmail.com, andrew@lunn.ch, vadim.fedorenko@linux.dev,
 horms@kernel.org
References: <20260815063148.2952-1-maciek@machnikowski.net>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260815063148.2952-1-maciek@machnikowski.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/26 8:31 AM, Maciek Machnikowski wrote:
> This patchset adds support to the PTP HW timestamping emulation in the
> netdevsim. It uses existing binding between netdevsim and ptp_mock
> driver to generate transmit and receive timestamps.
> 
> It also adds the selftest to verify the hw timestamping functionality
> running over netdevsim.

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.3,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 31st.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

