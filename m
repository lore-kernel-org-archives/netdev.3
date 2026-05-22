Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5149B3A7F41
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 08:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438053; cv=none; b=prxCdvlz/f0LE0IQNnMYALrnu3TIADWJML3DEizgyT4optJKTFk5bVfk/xYgAUBn3e/UhmbbunLr8KJ1jmUgE6PR5hQa2UDlYoogsqTAPsPLILIW/HXYE6R6nfmRQBNt6CbwFpNI1Uub31P7fzqGEjzpnZUnWD5jmxeQo53gLr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438053; c=relaxed/simple;
	bh=y3gO1/IRDX9AoOFixAaefYA8zXXxRvfVy4cVwEKXiFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxiY9bxpegi6fbSA1Bc8Gy3tFbtrIcDMONTgY+E8d8iwx4Z02TjerAM2C6TTmgk7rdpA1viH6JWvt1A9fCr04Jk871zjxZlhPq/D0pStcziY70E2fDcMZjdzV20xuh8KJBIaxUamm5FyFaxB/6jckz0kuRf+D/s14WllDXivykY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5DcLO9G; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5DcLO9G"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-44b330c5cc6so5283085f8f.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 01:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779438049; x=1780042849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtBUHZ5NTfzEhm+9SPa+wbOEFPDSpIs8MinMBuqfMJM=;
        b=b5DcLO9GA8hDubB2tbBsRUXaFsFbl1WJwxLjAHY0kKjfVRFzFKiqtC8OBwSWwa4fwC
         Yhw4Zwpj/cA9sWKHopD+O1Q9XcVI19WDQhoXFNHVGD3dTg8rKwYfkQrERm1AcHbSkPp+
         4vgS6f7No46dqCt6Cy/aI3Ix4RbVvYlZjY1Lp9+21rzVC3rmtxPrvLY7Zkm3LYWYwX8e
         oiAFAEyWCw+rf7SUb2TvL7gH6k+dVvJqJJgjjWyF79vNk82YECPtchi8AsL9nS6Jfxjy
         RWJUXUxBqa8UU+EIiCd27YVkg/QBmC47SZDRvQZUTOB0PUsk3cSVFL9KNHbmj/ql1iGM
         wx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779438049; x=1780042849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FtBUHZ5NTfzEhm+9SPa+wbOEFPDSpIs8MinMBuqfMJM=;
        b=iTeksG3EDW6lGBZ25MQCZ+P3hJbBWMaUFl3c6BPiDH4vRerJROqHz8sOJA1WcWbFBS
         f3szlWmXSJYVxcHlmKTsG0lMFaHnjOLmnYSlBDQlPy2Kxz7Bfg4G8ECTmqKYwh8vqUzR
         JxwgjdJFqVQqBUqAfbKWLhZidG+4/Gbhmb/Mn0458Z5l8+/a4lyTn0LkYEDa0TSUSu9W
         lXe8UG/A759VrcSN7kX+7OHzEstigICz+tRCi0QO+MjeJZfkQvymyuhnu/cos4IPqEHy
         LvOt0YNi17hMGie0nYP3ozc+r6LoEtBw+pqXZ8D8qJ0fw3xFuor6BbojxeqPGdTim8eh
         ac9w==
X-Forwarded-Encrypted: i=1; AFNElJ8tlHJlythKmXY/fHwPqmIpTUAtqAAHfqfliNrKtP7JFUDpshgahANZZ7xJZS5GDsg/eSUTvJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy482Zjrn7jTwwBj0mozMrbOgZuH1EKrL+FFZsmtH6cGopSj5hs
	CpH71sp6h9YEDNjjZMHLtADnmiB9QVh8n2xX00GGoRoSyha0WTuayoeU
X-Gm-Gg: Acq92OEAgEg54J0LRY7Och5D/byR81LY+EC5Vx0cfRCigxCNDFNCiNZCAq+JJ7c1W1S
	bTcSJMD1gaWxkciwN9Vr3PMwA0CYGkwYfV86KWfpOgnTdTnj6X5sDXGu8W0AAmXnDnU8YqDAb8r
	gRFlPCqR9NQRPs8uutawFfT+C/YXBy/HP7aI/Dl8wRMdEbk0xawY1vqbdjjB2tjwXsikqiLuN/b
	T5YrrJ8WfQLZsIYBpNXaVErzt/1FOcdQKupopOwIP98ZpRWT+Fbu9LuD1xQdu1mbVHydTcTfv7Z
	6QMg23xxjnZN90IcRjKSEfyVv67YWikYMbVScRgGbDBUUWz9gUvFdQD43vh9qTF+vnnv8PuvlcA
	2k9HtIa2KufMTqzBBmSRxkvnRxq4wYipTmxGJDuQRKIuTUulDZdoIKjB6RMZptU+2Qypf3f+CZG
	iHW/QMojvlYFsGZk5LJE8ffuP/VEWCoj+e+hsyGKE6IO5Ywy4TLyAevkEdW/GuaFMzyl0iCdANy
	eU=
X-Received: by 2002:a05:6000:1446:b0:43d:7a97:78af with SMTP id ffacd0b85a97d-45eb38e04e3mr3459686f8f.42.1779438048957;
        Fri, 22 May 2026 01:20:48 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d49132sm2187929f8f.24.2026.05.22.01.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 01:20:48 -0700 (PDT)
Date: Fri, 22 May 2026 09:20:42 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ashwin Gundarapu <linuxuser509@zohomail.in>
Cc: "anthonylnguyen" <anthony.l.nguyen@intel.com>,
 "anthony.l.nguyen@intel.com" <przemyslaw.kitszel@intel.com>, "andrewnetdev"
 <andrew+netdev@lunn.ch>, "davem" <davem@davemloft.net>, "edumazet"
 <edumazet@google.com>, "kuba" <kuba@kernel.org>, "pabeni"
 <pabeni@redhat.com>, "intel-wired-lan" <intel-wired-lan@lists.osuosl.org>,
 "netdev" <netdev@vger.kernel.org>, "linux-kernel"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: e100: remove redundant static variable
 initializations
Message-ID: <20260522092042.5773213f@pumpkin>
In-Reply-To: <19e4e74ff40.601fab765713.9212104302286035517@zohomail.in>
References: <19e4e74ff40.601fab765713.9212104302286035517@zohomail.in>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 12:22:30 +0530
Ashwin Gundarapu <linuxuser509@zohomail.in> wrote:

> From: Ashwin Gundarapu <linuxuser509@zohomail.in>
> Date: Fri, 22 May 2026 12:20:23 +0530
> Subject: [PATCH] net: e100: remove redundant static variable initializations
> 
> Remove '= 0' from static variables eeprom_bad_csum_allow and use_io.
> Static variables are zero-initialized by default.
> 
> Found by checkpatch.pl

Not worth the churn for existing code.

-- David

> 
> Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in>
> ---
>  drivers/net/ethernet/intel/e100.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
> index bfacf877ca40..bdddd4315cbb 100644
> --- a/drivers/net/ethernet/intel/e100.c
> +++ b/drivers/net/ethernet/intel/e100.c
> @@ -167,8 +167,8 @@ MODULE_FIRMWARE(FIRMWARE_D101S);
>  MODULE_FIRMWARE(FIRMWARE_D102E);
> 
>  static int debug = 3;
> -static int eeprom_bad_csum_allow = 0;
> -static int use_io = 0;
> +static int eeprom_bad_csum_allow;
> +static int use_io;
>  module_param(debug, int, 0);
>  module_param(eeprom_bad_csum_allow, int, 0444);
>  module_param(use_io, int, 0444);
> --
> 2.43.0
> 

