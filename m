Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07E33890E0
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781875231; cv=none; b=UC+IVfbM2zgDXXAm7HpaZh1ONb6O0F6i9SonA07Xf0RWh1uMnouIkO31Q0Fr8uCBuo2ucyVOM/J/bhvLwb6BlR7UFvwBfbhXMsbKx6f8TEcdqiHuRCd+0rY5qGVta0XKQZwbEJz8VtPPjmgpdPJWaCicemmyQsgBvmNSIFXhc5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781875231; c=relaxed/simple;
	bh=ik6f+xiyVZf8p/ePmVvntAqGeuAewyuoZ9dkfDvrgnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PdjELzq0Use+nmb4skriILgsYzNe4H9B0vBMAFDf8Vk12f0nyJDYXBcojZco9BwIKYKTVglCrB2E1OqBOTdDGfuS42nlA0dgxAqrfCrUF//LNv+WgRGJ66ClLsikj8gHnkJu5/uKgAI7cYxa2KMf6hnMLJnQn90J05MYH+lUi3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHkIwS/w; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHkIwS/w"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b4a8e28bso15946625e9.1
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 06:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781875228; x=1782480028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5jTtn7ASYwiZX3Iefg8PvDQB0Dcy98LO2xsckefXfQo=;
        b=GHkIwS/wA7HB/axNPfimqmiOGF0o4dWPPiUJzm7aTieZB8Vzzp9ku9/IFsKLy0YexQ
         TOcDVIYbsvgv7lXzMRiQtpltJXGFjtHJ+7DR0W3ywZkD1Z654BCZmRTEpYXsEjMpU5nY
         zDZ4RVusc7T2KtJ6fVmX8gPDP4qcjW4hYtTptsePbmR6YqZ7724b8fdokpYPGE0IJwBv
         nLrYcDOmU2Q0NCY4gxYhVPBOi/SgPPXPHGmhsrOfKlfzs4T6aAVNAKf6VKeR6v3zkt7I
         oXPkQOZWqp79MbxANmCHqX/jsnTqU1xr40xGUekF9ApxHGyOve3ytdRzOB/U/f4cCmlE
         2ANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781875228; x=1782480028;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jTtn7ASYwiZX3Iefg8PvDQB0Dcy98LO2xsckefXfQo=;
        b=mTqLcjNFT2bw9ogTX+pSVLKjjE6iv25n7vDuvjA1dsp7aVapcwpJ0O8ERx7C1OWu9j
         XblaTWCppIBiBDrr1NhuUiUSZe+jbqzej4cI7LEc/KoTuUYPhWvU2ML15IJI+lqDLQNI
         KEhpHYZGsOmo5WnkcmNI4MKA0G3zbAylJzIs2tVqaWJxb8eosAhZ4MHajy197qKz6+Ek
         Qi+2jHHpufIrq7QkvhJeKNljYZCHuRGxFzP8QAKRcNmf0wD80eLPgFMr2kb41SqoxirZ
         Kknn0EgBzg1q2mevjxGFdWj/g+nBXQOYzkxdWag4nKitOEnMzEmS3xAz1YPdlu7q98YA
         2Q1Q==
X-Forwarded-Encrypted: i=1; AFNElJ9d7UIyvxhPwUgyYLAgonkjrYtN+O9aelYq2/c/YGb4A6YZCzB1EdBY4l3XHqJUwAIhCH+qN3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOscTn0TF9yjoQmHHORZW/cxafVLXYfmmIJVRs+V2sQlwQfYzM
	EMIhAdfx6iRlDHA2sPcLdrQqAP16ssqxadetITfzBQz+1oTXNfRPg+Wb
X-Gm-Gg: AfdE7ck/3JDchrKO00bv1WdzSFFCeIo8wOZMCyjNhAJ8pQyp5EeCnuyXYyX0D/K/jqc
	/8ZipIEFXx2OpiOvQKWQx90rs4qa2RfL5CkyNKMCGqLgm4qg/y5QXiukmp33BJ3irs4B6R5xuhc
	UtrxbYNV1WMInkSQ+MoysVZfwaXrX/vAcDdjCZn9YiNCVUFnbWUyB9leIo+ltFFCfnfw4zjTaFd
	cL+SVvXrYNfx9SOLqHpRlTu61Hc+dDcErWv57tOBu3PsvBLmkaDFgYnZ/BzCAMR7A/YXFjCLRFn
	UVQmNe45EzttPDVCyj8ivIMgg0ah9pR2PrkNb58hH7Hhrl5GD/xI74aWhoVIK+z08HCOeVTW5Cz
	yEPFLL3EliBjMRrkvrAsnrx8SH1vwooH45D0k6R3Tzq2p/zfhNbMcaDOjm0mKhoB3z/Jn5pr5iM
	aS9ctpoE7WAYrRLGtpkqjETC6bQZoyniB7apIhSShyMwE9cri0Sp55lRAPzSiO910osDMAHDmks
	2T1EmyACnxd2g==
X-Received: by 2002:a7b:c456:0:b0:491:8043:5c4a with SMTP id 5b1f17b1804b1-49240e95431mr44754845e9.31.1781875227880;
        Fri, 19 Jun 2026 06:20:27 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd1ac18sm101853255e9.12.2026.06.19.06.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 06:20:27 -0700 (PDT)
Message-ID: <175fccd9-5353-4675-aa2d-09a98433c37e@gmail.com>
Date: Fri, 19 Jun 2026 14:20:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v28 4/5] sfc: obtain and map cxl range using
 devm_cxl_probe_mem
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, djbw@kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20260618181806.118745-1-alejandro.lucero-palau@amd.com>
 <20260618181806.118745-5-alejandro.lucero-palau@amd.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20260618181806.118745-5-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/06/2026 19:18, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use core API for safely obtain the CXL range linked to an HDM committed
> by the BIOS. Map such a range for being used as the ctpio buffer.
> 
> A potential user space action through sysfs unbinding or core cxl
> modules remove will trigger sfc driver device detachment, with that case
> not racing with this mapping as this is done during driver probe and
> therefore protected with device lock against those user space actions.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>
