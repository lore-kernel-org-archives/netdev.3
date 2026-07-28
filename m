Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C11377AB8;
	Tue, 28 Jul 2026 05:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785215517; cv=none; b=qjgh5iWo7Nj6rHQcWwTR/F6eVCLcP5nA0Q02BghG7so0vwiolfCEwd8BSJIf1+NmN7rD4rVIoyr7ysBN+bRHS/HjcbNsoODeLISfmoo/Bn9WS+eyul7tqoek+gck3F/10M0TxnC+DoPhmIyCTher12Kxn1EYdTjlDNX2n0mKD1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785215517; c=relaxed/simple;
	bh=6ir/ROIDpAkUpmj3H4JBgZZFt+E03UEgeqLWb7TyAsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QuV9wJeOV3cr3jGVDyPpO621JFEEEB1qMHDryuIaIsAd/vHnUhXrEKE/5ROSQh8BAYZ38kih18t91Hm84YCxLtETmdc//J/wrVoMKMAK4K+Ag9xQxtENL6bgGG/22kQy3Df6xxvpNSZISXAQPhJv3Zme3ODe1B7I4fsAsgvEYPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=miE1duHO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="miE1duHO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=u91pGAFPUKc1QMlWjuzEayvR4uX9O01iEVUE2c+uBzk=; b=miE1duHOSC7CkPK6XMCfffN5EC
	FQq5PG4Oh/LgNuH10lYFTje3Gf6sGTqSQum42wR67xX3v95qQ6x8+ZnyaezHRMsL/8CzHqr+8+GWf
	Yqv+KR/hBEp8QuDCQLqOoYElYBeMXkVgkZAlYSzWuIUDZFXSnP5svImfd0qaRMZWvAIhVJOPjKNeM
	uW7p0FBF/K1um+8iC998EPau5/e4RZ7se5tERuYOofh1BjRHhL7/QXr71AFlFXHmPcY9u7n6o0U1R
	uS7+kjbaVH8CBLR3iq6ThCfUmLWGqADtBWh60O+4yRVft9xMzp52Mvgib5KPePyBB7uSFqfskLM4z
	FMZPxf2w==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woa6b-00000004QhR-1GSv;
	Tue, 28 Jul 2026 05:11:53 +0000
Message-ID: <e0e571e8-a71a-4d93-948b-1b78e89e0219@infradead.org>
Date: Mon, 27 Jul 2026 22:11:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fpga: dfl: fix spelling in sysfs-platform-dfl-port
 ABI documentation
To: Ayananta Paul <ayanantapaul@gmail.com>, donald.hunter@gmail.com,
 kuba@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260728045802.9551-1-ayanantapaul@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260728045802.9551-1-ayanantapaul@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/27/26 9:58 PM, Ayananta Paul wrote:
> Correct the spelling of "responding" which was incorrectly written
> as "respoding" in the Document/ABI/testing/sysfs-platform-dfl-port
> ABI testing file.
> 
> Issue identified using:
> `codespell -D - -S "*.bin,*.o,*.a,*.so,*.ko,*.gz,*.png,*.jpg" Documentation/`
> 
> Signed-off-by: Ayananta Paul <ayanantapaul@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/ABI/testing/sysfs-platform-dfl-port | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-port b/Documentation/ABI/testing/sysfs-platform-dfl-port
> index 65658267fcc0..40e555abca20 100644
> --- a/Documentation/ABI/testing/sysfs-platform-dfl-port
> +++ b/Documentation/ABI/testing/sysfs-platform-dfl-port
> @@ -84,7 +84,7 @@ Description:	Read-Write. Read this file to get errors detected on port and
>  		to clear errors. Write fails with -EINVAL if input parsing
>  		fails or input error code doesn't match. Write fails with
>  		-EBUSY or -ETIMEDOUT if error can't be cleared as hardware
> -		in low power state (-EBUSY) or not respoding (-ETIMEDOUT).
> +		in low power state (-EBUSY) or not responding (-ETIMEDOUT).
>  
>  What:		/sys/bus/platform/devices/dfl-port.0/errors/first_error
>  Date:		August 2019

-- 
~Randy
