Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA5B3EEAD8
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 20:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788466620; cv=none; b=libcYm9l8cyXTFZXp9KNgdEAhMRMiebx9WDjAMCREBS81PNmQoRNqiBL6RLIizRjz8Y4NS3Gxsp6PPzEL0HlHCWXofM4/DJtuIutAWib18ZkCAj2RWTQHPp4v1h3B7LJcJHLmYNuKnvLfaDQcwIdTDX6/atfharincBVYmWV+ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788466620; c=relaxed/simple;
	bh=PTKZm5A1zw/ztNb0Q2EG7ip+3Qq+y4cDNIqb+5t9QSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTEMX9/lRHISweC8MLHcMmzzoEnTb/iDuPz15hvgk7TNYqqFcYqfiBxsHsLA5iu7ktH/kGvUrC3fS0UVSkRprK/SBxHm2ahKQ0IK7S+3rE/socCDHMsGC07N9jnEf6OQmHbXnP9s/wj9i2R1GnOEc+S7qf10zmvt5lgOGGnQUR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=tLx9PC2F; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="tLx9PC2F"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-85339ed040aso184531b3a.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 13:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788466605; x=1789071405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o2dK8ZSSh7B+/fdJOT9SFqAscLYGeyvxmIfzm1v3glE=;
        b=tLx9PC2FL0AQvJ7K34o0k47IVXce8DrcNdpmLFgcEH+AVelvUqpZEd/gzNEoh0O7eB
         ogcUnaoABfhZh9T3EaG7F+vQNq9kyqEBx+nhnEol9n1OaeniDpQQValLdjK6g660haw7
         7kTVC/5htGKGaKPUFrboQZJ5GajFpeHUWIaKQD1pusKrYt9pI2wo/6V3krlaxytq3Heb
         2+jyWtdpb0DT/QMjdXnknzQ+ywFnuv6zIb8yFaHbiukt6apLQ5BSsl3f3ks9wzwprkc6
         DVx3BffVKUqHUq2Xn0TquS/dbweAsQN0GZ1vBN1AoXl9IWXO0rZM8haWzG5JAWMyMo/k
         rMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788466605; x=1789071405;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o2dK8ZSSh7B+/fdJOT9SFqAscLYGeyvxmIfzm1v3glE=;
        b=kmt721EwxINBRv3p7O+D6QUf6cd5QxiagFe04yxa3RH1HA/m9o1Xl8La2P8H8Y3rRJ
         jNUnkm7KuGxTUMi4zKbM6ng7DkmMv8BTy9ZyceY60RRx/JDQJLYeHrCfTAltXT49MkBQ
         aRxDSQhWhZ1+OuQIyM5hAM7nIm+A5ZIlnC3HnSw1ptwh5txAdux3DWk3GRzw7+gmkcXd
         zP7WPVMt21PKErdd2wsjxbVh2pAJn0GezoAu5K8TG4hHvthZLpZKKGACMTFANVpbhTRI
         sd60QgKjA3WemMTx+pPb/Y+9rmUSxfQZIVInsej6jCFtFR4ZFzHLstYtthSkygLpTSqt
         Yi9Q==
X-Forwarded-Encrypted: i=1; AKwUvBzer83EOZ6Lwyu0nWdU4xNs0d7XxNOZkkqyKdpI3v8x9rIYIO9t3JTlH2URIEwjXgqodDpPGYU=@vger.kernel.org
X-Gm-Message-State: AFuF++mSletsDNvYRL/qVXrYdEJB2SPNR8HiSeDNuxrOVf7J8FsQWoLu
	MQzuZgv2aiDLv8IfaisB3rCAn8IpWPiAZYiEYLoTAE86LL5aPRI2QgjJwlMCkKVXqys=
X-Gm-Gg: AYBFou25U0DvtcM7hmx7+3g80C87vwyLPb5ImY5R5MmshDPb+oA/Hwo08vkkYHpf9fI
	AaU6Wnb4GY+bvMy3mJvk6CO2fL4hq4v3mfCJ6wcwMnxp+iKXa3OFvDB4vXd0HY4w10/yphnsLWi
	HlIxLEWyHuVBmTEFfH7qbjgkK0ynvs15nDhnSgZy7sVVsIGBmIMwfP9mQLdB/3OHN4NsWGx2SLv
	HpNekhWa/O2WzKXaWjHTBbEIy/wsmAsPPe+REJvHQOUpDoHJ1ecO7BzimvIUnu+QFDUaJBOJYd+
	G0RHXYbQOEMegR8+xu7SJD/+7BIKHb/T4gkBk+ecIF5IUmcPC792SVmWtIOoKhhkGgtLhiDpj+q
	LOXaqylBc3KIG4C7Lk3Z1VMRdJzR+PGy1HU53u2BYAHUPGl6jeHEcf0wJ9xS1jkmKWlPNbTz7Te
	Zy45WuWoX/aqcYJHMWjXBQ0rUbLC+SU8lBRd/ym/p6vw==
X-Received: by 2002:a05:6a00:32c4:b0:847:7f3c:b5f5 with SMTP id d2e1a72fcca58-861671b9567mr2366231b3a.11.1788466605099;
        Thu, 03 Sep 2026 13:16:45 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:53::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615333496esm345547b3a.43.2026.09.03.13.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 13:16:44 -0700 (PDT)
Date: Thu, 3 Sep 2026 13:16:43 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	florian.fainelli@broadcom.com, jonas.gorski@gmail.com,
	andrew@lunn.ch, olteanv@gmail.com
Subject: Re: [PATCH net 5/5] ethtool: document that GRXCLSRLALL rule_cnt is a
 caller-provided limit
Message-ID: <apnVq3iQZeK2uy9t@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org,
	florian.fainelli@broadcom.com, jonas.gorski@gmail.com,
	andrew@lunn.ch, olteanv@gmail.com
References: <20260903032611.3000029-1-kuba@kernel.org>
 <20260903032611.3000029-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903032611.3000029-6-kuba@kernel.org>

On Wed, Sep 02, 2026 at 08:26:11PM -0700, Jakub Kicinski wrote:
> Three drivers have shipped a get_rxnfc() which dumps its entire rule
> table into rule_locs, reading rule_cnt as "how many rules do I have"
> rather than "how many entries did the caller allocate".  Nothing in the
> callback's documentation contradicted that reading.  The distinction only
> matters because the ioctl lets an unprivileged caller pick rule_cnt
> directly, so getting it wrong is a heap overflow rather than a truncated
> dump.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: andrew@lunn.ch
> ---
>  include/linux/ethtool.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>

Reviewed-by: Joe Damato <joe@dama.to>
