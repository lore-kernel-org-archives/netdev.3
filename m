Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28324FB9AB
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 21:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025267; cv=none; b=a3XNUr92aaqbh5j7cSc7S3srSLzDraB20Z+4ELs6HVbAKtDk3zTyzvjwe6EqeonUG+OdR1cxnb7kdRCcaHwuBTmxxMXQc2rlQKwE8SfJRzuMg+kcSabfBRlMCIFbiqumx81K5Kip2QWcPNjQg8L/s1tB5waed1Z+LPyZT0/UCQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025267; c=relaxed/simple;
	bh=XS1YMEVpHPzDaVnG9EBRdMCW91tgJe7gB0Z+STtdG+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jC40kzCrSP2wVpRGBUpHU3ofTez9yJA3vIqGzaKucPZlvi5OACpCrzoxbfIfF8T8EigNAIQbrmG3cYih5O5yZP272EJa33+ZAEOFCBKOAWn3w3v7uLk0M3fTqlpjx6cBxEtGKzAdINPeae8HDHD2YH1nF4FAIufdOc2rmDy7yug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeRjrqGd; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeRjrqGd"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2d6fff25530so19368295ad.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 14:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790025265; x=1790630065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aiWUOiuDm6CAFEe4xS3PFWEDjV6z3757hGCxI18TLlw=;
        b=UeRjrqGd7t4ho9ieyA6KHErrv4f1arIksI74UdiyqdttVCUUom/DUhckC/vFX+v5q8
         H8tIW700af+d/HY5ONTfJlKu2GlB5upxTdRRui1RFui+/vNc5WA9hoXvKR9mo19vB6Tn
         yYuSPghTcTvYncSjg/xEfVvZWP83iQmdv2EyNTr7H+ZFquTuxQ4jBR0IkPDl1h7VS+Yl
         C3Le0BWzn3oDR8VHN+MEUaWGJrm4j3WxlmjUOvGWneeWbDzYML/vrD3HkUncCtBLNGUI
         RYhoNG5Sk3UjvZVhYLOM1Qbj84WpybRE87ZmlgWwBCcyYE8Ty1R4yH1eynuEBVPzAhCQ
         jCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790025265; x=1790630065;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aiWUOiuDm6CAFEe4xS3PFWEDjV6z3757hGCxI18TLlw=;
        b=BV3gdrpBxVWz7ABwZI1k1k/i9YZQIFF3pJZlznjTE4oxHe5omMgBpldGnFgMh9EggZ
         u5b95T6cMSA/6/PQRCFkZpkoE5+kBigvTN1XCbJb0AXVpM1wGADa4o+xuKEWUbGGn9fl
         ITq5F8mTfQ6ZZVCKZrAxfxTmK+It7mxu7SHqEf6KQy+k8e2BeMkmhwJQ5tNbYjwCbgAo
         G4kIam+jn+jHe3I7XteaXLx+vhEhSlL/hBsgk8WOVwO/kX4b4rUi4IlB1IOFeI7TlGoI
         mPd4qXj0BcwPt4mzdPcK2vXQRtcLr2w4ATAUkntYuimQQ8URY1szxGY6VPv4QP7Ph6Ry
         9RRw==
X-Forwarded-Encrypted: i=1; AKwUvBwzxlDcHoK4O7tmMREGwgJkBHDtfDKmwGqd7Xv0SS3dvBJTYE5XwxxCmTHT1mNjyWe2icPttgE=@vger.kernel.org
X-Gm-Message-State: AFuF++mftvwzur3ZQE6b+bIJqENmqPF+38f4mdPcze7IOujs6UuDwu0V
	t1k0q6lIBZiZdiB3VKvcMEYOxzx4vRrDwhJ41VL10GrXCjEpo4r5YvhBGKr7kYWJ
X-Gm-Gg: AYBFou0GpLmGQM7x6L56a2S+1wPBwJw4xGWiTxQoTi27JKc34kUA1c5NZXHUpfzZhD+
	Orz8wsCewShZdsfDiivv1Cjn+mIWxvz8S8Ua9e2ndkDt8KOIPT6XBfBAgJ0F0n90IVBiLF41Xzn
	EmKgluRFzbr7NSA/E83b0uSt5DuNYPNaF0rDOjkCYJCplQds/qq3CZHiH+HNs4hk/hs868lrLXc
	2rRC9THvyvBNIxq3c3IoqEUAR7htiqAfP03DtyQqx9ypQcoys+RN41/iow6jw2XpCk5cniFHHaJ
	xhlItoez78gtklbggW+aeKPNich8BbkNhP0bVy70ZurYl6AvqTHxqtTG6hbg5TgQjV0r4EdcOCj
	x72YUSDmWaSA+5KcdiS7JP1fGVZebuIwELEcfhxsWpViYhxlpgOJTAjziDSpH60emsjoAsNht4q
	ZuJknyzaeBGoYf8Yhy1+V7+WqTrgIu+bHOY9NmrV7LxyBcCXxKjHQ2nWrWmV7tJhb2Usv/0fWGl
	Yk=
X-Received: by 2002:a17:902:db0a:b0:2dd:c100:80b4 with SMTP id d9443c01a7336-2ddc100812amr105481545ad.47.1790025264866;
        Mon, 21 Sep 2026 14:14:24 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5b7c03bcsm666905ad.55.2026.09.21.14.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 14:14:24 -0700 (PDT)
Date: Mon, 21 Sep 2026 14:14:19 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next v2] net: opt loopback into instance locking
Message-ID: <arGd3auaaTerBqNb@devvm7509.cco0.facebook.com>
References: <20260921190452.1467853-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921190452.1467853-1-kuba@kernel.org>

On 09/21, Jakub Kicinski wrote:
> netdev netlink iterates over devices when dumping queues/NAPIs/qstats
> etc. and takes rtnl_lock or instance lock depending on the underlying
> device. Currently even if all the "real" devices in the system are ops
> locked we still have to take rtnl_lock for lo (only to find out
> that it doesn't even have queues or NAPIs to report).
> Opt loopback into having control path under the ops lock.
> 
> This is a pretty obvious thing to do, I've held back this
> patch because we used to only apply ops locking on physical devices.
> netkit queue leasing made a precedent for (far more complex)
> SW devices enabling ops locking. Now adding it to lo should
> not create much new bug surface.
> 
> I considered an alternative of adding a "predicate" to the iteration
> primitive so that we can skip the devices which obviously don't
> support given API (eg qstat) without any locking. But it's more
> LoC and real_num_.x_queues is not currently WRITE_ONCE()ed so
> it doesn't work too well for queues.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - move setting the request flag from gen_lo_setup() to loopback_setup()
>    to avoid splats on the blackhole dev which we don't care about

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

(mostly because dummy is also ops locked, don't think loopback should
bring any problems)
