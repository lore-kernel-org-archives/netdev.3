Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0635025B09A
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782405865; cv=none; b=R2o+hCMXVOZdkAlsVSSB8ScvYRvcfSgYUoKqxlq8IiUc5Q8sNTiIf9enB3xQPtF420kN8YZyRTztaSyUhuUxgQw3WtTxLsjSjmJmDUTG3mpcNodxJzbDKqwrtEULFv+Fj5IAoREld3jIELsSTHqnIzKXvmqpQ3OqmSb9zu/ARQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782405865; c=relaxed/simple;
	bh=P2+ReacPCeqU/fKo9jBbrql6rfmKkcgJUzlpxwAN/o8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ZiPnUEJaRY9EwftckMZOJjlgWIJaR0zd3+cqgZ7n1wlxYlH/6kdLQ/40hvIcQzwulC/W+HjXZLjnECQ5CH0SZSAHSAgX6l/NIKYad7cKhN+hengvFl3coSdQLXg2WE7TkBfEixPNMV5GSqUI2QEaDWqeeg00YScV/kqkz3c7Uh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMJMIzE6; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMJMIzE6"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-69ed219d3ecso11048eaf.2
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 09:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782405863; x=1783010663; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7W/ggTwnqmzWBnV2WV1SHqoLx9vAqZSkSoEPfkHk5g=;
        b=EMJMIzE6YZ9QJzbgGckgqJ4BcvpUQQv61rNrBh7KyGzS+927hCTboE4mKXsWuZpPwv
         yZs2FP+wZpxxmf7LMIduAZXhhj9SezF4VF4DXQPFZg369DINm2bK74N1FgmCHQq+ULkl
         qp+wXlYwzLgNlfO4TssOI9PbeSTqds5WFxxx9WBkrpPF/xw6HaFabsm10Lmu2hQ3jp72
         NlueDYdo9Czm17ifriUAc+FqLgdiUxI+tQQRyZkDodGl9JDKHbLmcrOBeB5fO2LHRGAQ
         iIKtd8/u4CD1NEKyRAX61Jd2d7mYv6egWzzHD9qDe53TPjClS13YhGUJQncRLmXp+a6N
         SfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782405863; x=1783010663;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t7W/ggTwnqmzWBnV2WV1SHqoLx9vAqZSkSoEPfkHk5g=;
        b=cEkLysLt+4jlue3LKSpcfJbG8pz2nn60B6+hQB/w0UeTzvwUFEaBux4zJ3idSjguAe
         a8qou8lN7iA2bkusw/hGSg7E1o7xeCwj8JwWdO27H4AfUqZ4Qpi8+uU0mDKfLzbsErxq
         T52CRSBpVsyG4kBjX1o0uwPe2YhP+AxePDm2m76vPrjs66wN+mUacHV4u/yRHEEIKun0
         t2jmEAGBLCqXcqymjAeAjJ5grNdw+PPErSP2bbYTWT3RZmxTsOlTMsFvTfkSjICczI6e
         RpwiHB8PHMNXAjZ4lqSs1+VgyJQ4fIVGe3VTVJDfn1F5teHbi4iKrse3Nei3v1B7W6+G
         7wTw==
X-Forwarded-Encrypted: i=1; AFNElJ+lcQGJaVolaGBIER6m8ZKQArfbo9NkIJvF37mGQVKlSNnOwbT69DdsTg5yNE2zEOxmHrAcNak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYEai7dCz7JUrE3t76GKSVsMieUZFsLOW4LJpRpc8CY6wstN51
	FPWZ/ZjuMad36eBxga1g/RhHveR/lk55p6NsrTJFN4UMOmmFjEhfj25O
X-Gm-Gg: AfdE7cmk2QXpHV1ZZTpxHh2+MuevDk0GN80V7LJSr5cciwou7hFW55cDeEevMp0A44U
	WlD3pXeMDG9jlfFAAeJfsuHTdzKv4QdeWzDY+TJ0034H28t1ODE8FatfjOeZhii9h+idzfx2T2I
	WJPFBBtcxAZIUU7Mw2xKitP4eHQ5BIJBH7zpm9LfDIffCsszQop+3EzUBzNUkYm4sl3nvVJ9j66
	Tm50jikk4NJS7QAVj0BuZKHTs3aosiLdmNjBAD/Ml9JAhzM+Y0kU/gps66+a83g+prKl0IV9xXW
	0jw+8++J5M3R6oQiDDjskgZwV/Am+cixdViXQEc60hGfw0jRhfLMbLy4SdUSx/pXusG+qj4TXt1
	VR6AMDLsp8rZeW6d3XE+zaerJAxZKQUICjst3zBCilUEVAgMWjJ52pj9NM4WKzg+tVMjwPwwSU2
	r+HLrbAC8tI+NOQrf1Jyuc0ir+WPXqVVUVLjf4YpT7rWrcoU5Z4vp69jvBPuBhMR0kdRCjYpwXU
	6JpivNNW3FbPLa+kw==
X-Received: by 2002:a05:6820:814:b0:69e:ab0:3f4e with SMTP id 006d021491bc7-6a13522493amr2720037eaf.46.1782405863009;
        Thu, 25 Jun 2026 09:44:23 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:10::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0ea0c378csm10370966eaf.10.2026.06.25.09.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 09:44:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Jun 2026 09:44:21 -0700
Message-Id: <DJIA58WBML8S.A897NKI06DV9@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>, "Siddharth C"
 <siddharthcibi@icloud.com>
Cc: <ast@kernel.org>, <hawk@kernel.org>, <andrii@kernel.org>,
 <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 1/2] bpf: preserve rx_queue_index across XDP redirects
X-Mailer: aerc
References: <20260620121321.45227-1-siddharthcibi@icloud.com>
 <20260620121321.45227-2-siddharthcibi@icloud.com>
 <20260624185432.32d90aa8@kernel.org>
In-Reply-To: <20260624185432.32d90aa8@kernel.org>

On Wed Jun 24, 2026 at 6:54 PM PDT, Jakub Kicinski wrote:
> On Sat, 20 Jun 2026 12:13:13 +0000 Siddharth C wrote:
>> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
>> index 5e59ab896f05..8f2d7013620f 100644
>> --- a/kernel/bpf/cpumap.c
>> +++ b/kernel/bpf/cpumap.c
>> @@ -197,7 +197,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_m=
ap_entry *rcpu,
>> =20
>>  		rxq.dev =3D xdpf->dev_rx;
>>  		rxq.mem.type =3D xdpf->mem_type;
>> -		/* TODO: report queue_index to xdp_rxq_info */
>> +		rxq.queue_index =3D xdpf->rx_queue_index;
>
> Do you actually need this or you're just trying to address the TODO?

It's a 3rd if not 4th attempt from various "people" to address this TODO.
We should just remove this line instead.

