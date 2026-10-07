Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACD11C5D72
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 05:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791350265; cv=none; b=N+2+tjkQl4maernXlDpIAyjsVdR/8OcIVaXuapQjC+5+oNiT++8tgJOZseY7CtKwxJP26xvzmQXG8h2q6xh/P/pkpU8yUdiZ/Mr/fe5fkX1WmmSWiAmtZoXjCXgOT6VuasE4kXDewBUMz8aXWQxPyUwSv1TOIAhcrlVCCOmEwBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791350265; c=relaxed/simple;
	bh=d6I42OVMMAfQ1pKd/EwfaBEW/IWSBYSJE3q5maVtz00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFRj0dwxIT42L8ulgQbts+mZ7uf8Mfcc6grYy0R4LEW86z48eo00aR6c6bauEEpVbsGtPFaRCn51KKYjPavLk/ae8IIH2zgmlYHWt3LcJGM0KWcSu1kCTzlTkb4FQIyc/MuInwjMh2FfO8hUdkUbWJJBFOE2z2lPycdnSnlZE8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=TFW6mb6z; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="TFW6mb6z"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-82395ae2ea8so3386063a34.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 22:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791350263; x=1791955063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yNBSC4dES3rHCfyXXYrULXRmc0yVP/bprqqW9esFYE8=;
        b=TFW6mb6zxDzWGVl0bYobdjVuFehnYSJXLPRHsV151yGyVMfxYoCIrY6NsYsgcxJMmN
         DRfyFDF5hk0gSOzo0x41ziCREkSMxBe5otGEROJfQvHZ/VSdfyzgOL30+sMBcBYsYRtH
         VaZolcx9POJSZwxCB5Hm+6FKh9gJCd9l2XH3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791350263; x=1791955063;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yNBSC4dES3rHCfyXXYrULXRmc0yVP/bprqqW9esFYE8=;
        b=gFoFVBBei7/bHLn0ZAGw5wOvg4XaTarTLxmtX0YBYOqStk6Zd8UUpT57vsTk5movAu
         7+LaZhgT6xnaLmmk24CIZSRw0+qp7BIukDxLz4WOZMfmXUuSO1kk+EAShzF0hXnWh0f0
         xx9R1BE1oZHz9CABHFpXvTNYiuBf3jLtmwgRo/LvOsib0BdI6gm/V57mZBrMHAIGoArf
         K7uRNFzR4YkXL5GkgkAQD/l7CUYIenblUgCHErnKNfGC33NRz9KZSDRI/B6c9+Xe6l3Z
         NtjMoOdx6BXGaK6q0iDXFde+Ya0IqYqp+wzyJwdK23qkl7n0F+hl9OcZxd6QZaw/myZj
         Iurg==
X-Gm-Message-State: AFuF++niHuS6+n0K+EknbquYMmoDUcxsVaIBQlQBNpee3GwVZ4Uxu6jn
	ohTIoPATBKBQ4Yz8C+qU7dYdKECH3HI4aWwxckJerWz+OEbBuDGnwtKmw4kFYWvAsKAAv6UkMRR
	7L3V8HBjI1Q==
X-Gm-Gg: AYBFou0O3zMMesxnzt87Lk8dMySwDK4O5Zgxps92pl2UK9nh/3hIzBTmeiQUCAo2JwU
	pCm7OHnYpWblRtqchFCRp62Aop4Lkjj6T6BnkU4Lujmi4dUe2rO17Zh4QMlw2mCVxSL79vhsZEj
	NfcpHi57zaNq484jmvBXhtHRD2zuP9DdYov5uFKjzDTWPZFU6BJBMja9GwwqrRKsY2bl+HPKxtV
	+59dNbCIDh6FgZhBL4zE1MpvUCx9nSQJUJz9FQVSQN+eiOpvXjjFTEpG8RxmkbfZ77pVcEH4mDm
	2CVdZiRCi1OZdNofVhfHxeojUoVqs/Ho3hylQKtptm1wK5ZBCycSLmcYpYH1O5akgHSYTijhrJl
	mwifZ+oG98Guz3EPI1tjMEvyVfcbmgW7tKPgWxzT0wequq/Npf+gr0JxSIINusXXJvl5tuxxoC6
	8H/ClJ35j6oK3NqT1eiPOJWhNj0qVLn5VW3QlGswX7ulP5CNdV+wHnB90w4qbcQD5sbGuT5f9xA
	E+xY7W6TBlwjcXwcvB2tcf5xs+TtmsiwTDtPydkSR2V6b0MheniNSyLy2B1FZCt
X-Received: by 2002:a05:6830:349e:b0:815:e63f:9b90 with SMTP id 46e09a7af769-82aca089b86mr2621790a34.0.1791350263566;
        Tue, 06 Oct 2026 22:17:43 -0700 (PDT)
Received: from com-75606 ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82adc3f1006sm1972452a34.11.2026.10.06.22.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 22:17:43 -0700 (PDT)
Date: Tue, 6 Oct 2026 22:17:39 -0700
From: Kyle Zeng <kylebot@openai.com>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, outbounddisclosures@openai.com
Subject: Re: [PATCH net] netlink: reset skb headers before unicast and
 multicast filtering
Message-ID: <asXV87wae2TEXSp4@com-75606>
References: <20261006224232.50724-1-kylebot@openai.com>
 <179132731939.2231598.7844526000530570814@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179132731939.2231598.7844526000530570814@kernel.org>

On Tue, Oct 06, 2026 at 10:55:19PM +0000, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

I have PoC for this issue and the symptom is that it can lead to
information leak.

Best,
Kyle
