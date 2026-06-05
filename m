Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14349477E38
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645949; cv=pass; b=fvMFI0Yp0FTJijeKJIla7KlHBG0bKRremdPDBMLq7HYCJ/7UmRMqPQmF5EjLLpsDsj+mPJhqimI5XtzcAccZQ/MipcyI1oWfuAhXd6EbOShnWRaFwYT/PuQ1GLCV8ebAPJU1IDNifMB9GLuU+utDCUEyNBPMQSiYfqPE+KhqrFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645949; c=relaxed/simple;
	bh=+0mX3Z/TsCcWbLidY+YCkmtqQD4YtPaeDugkEa+idvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBNxzt+FkNwxQOLosp2fvZ4dJRb1IP7nydV0Xzm4tFk21k+RGroJ5m2REec0RkR+L4Wl4jkupuLCAsMIn2qaeZt5bblVqt+8GzE+7TCrXIEATiftkU6QFMSJt+g7g4NTtA1vTiua6RDwhI7N5P7cnql+L7uLcGzLmqq75PWTZqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Pf6FAlrP; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Pf6FAlrP"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39676ff4674so14452931fa.0
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 00:52:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780645946; cv=none;
        d=google.com; s=arc-20240605;
        b=bxSORVruXykvsXyu+GjXtJ14KANvC1IC4UJovMcsEs9DinWLwCW9Gv5YQyHeqjcFgA
         BNEznO0FTFehmHrziddUvmXkq1wLFhxO2tjU2DvNRry6tFh1ZzHhRl3YhtD2Y/zIB3PQ
         vd2Y1J/Zh78a1UWZ2ms8XyiC3yl7alo9chetkJ+hxE0q8IjbKC8NBHcfS68pyMfLXoAb
         ATJw+rz5M/msrVRSj7QRZE5ETouKvO9yfahadyz7OrK1s7KqWdHJo5ic1wryBPaTbl5y
         F2vRygCfs1Jn3xo9kr5FsowvObPsqq0+0cdHbNjD1XhvdCa4szm6GVhtcbPo1hK5K2Be
         b8vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8cXL9lLSt7hAPzIQpliF08rFkTxmNTXiV4ktif5EGBM=;
        fh=9cY6CHec0NG9XO1DmHQ8+zlmmDE008fDigTfyQUL2K4=;
        b=O9jgPFWgjXTmU+Kwg4PFxFp+FaQU0vwHeL4grJgBQgWmHOaE4bj245fP2GcYd1pFmK
         cqcBg9SJrX8/hEe4jt09o/2tCyF6s1iPYsf6ryUyymxAsNLT5LxUJnBsJRPQn5UHhjHg
         zZllQ+ZnkoivgZQ9Jzrpd71NwWX+1uHfHOyfd1c0Pc8qTxfdKN0SyCwIbtTC37Mq9i99
         zVBskmtvzZcZMtUluzbP3en7B1JbkgMUAdrL1d4W8DMsIiqz4wcjQRUfVClbghdnjQDc
         AGsAntedm7/w03kQLUYkxdOsKYlBS1xIgQux6/oU2QXNq6DOjbCxbK46EQW7UrfBuyA0
         OBrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780645946; x=1781250746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cXL9lLSt7hAPzIQpliF08rFkTxmNTXiV4ktif5EGBM=;
        b=Pf6FAlrPL9P9Wez6+IoLyYZXCfWapoRbQQ+/YXIw/FtKWIofyBBGsE9gJk1ifLCRii
         MG7NVeAwyxVCYHT9ktNjYKXdwIl0VJjegs177HCd0HoMGLVftOFjsRGyDkDIgIhzFhSV
         Uqt9R80bhEKvGXiaVVjCmIjPSilvF8tJkLp1JXSX+SDI7UrxiZqlsxInE9Gm8VJs91lf
         zZ3m0cznuS5FupHnN+51gcVz6qMQY821iCsK+I+bRXKo7kEKFy4Q6Me76pV1QkdSrvlS
         BmBfjwl3DvBiaVLZxf0atQJl0wZbVi6pV0O5LmlsdEhzvc7oAdgxZ6X+VxUVE7Tpjj17
         b74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780645946; x=1781250746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8cXL9lLSt7hAPzIQpliF08rFkTxmNTXiV4ktif5EGBM=;
        b=eWlBxYjWam43vShWRJjnFr1C8Z6CPA8YfMINmrdrJhr8wF5e+H9PF4dU1vNOLOa0xW
         pC2SCxl4wixZpCjgFOg91B2jOjDnuTkoyZSzJQHRMXsJuDue/oAvJqGDzgMaMcaZraMb
         nbqZKga9qf8l+7rZbzRUM2CXbtMkXtJ1KQhO8teEoAG9HoQTZaZMnq7TaibodgjRuOno
         XL45/yPICr+xNKHcvobOD479JoP6+NysydIhxGckCBofPyL3W4+rWz84pIj2fURN+MA9
         ADaNs1xUsBiEQPp+Yy/XlGXqFv6S+4GIGq6zYClUXFbQNXn+eb5aWYaUXkXwQemmbQL3
         9KUw==
X-Forwarded-Encrypted: i=1; AFNElJ9FN+KoHbNh97n3rbss9oryTU2wJb6bEyqFIX8VO1ktoXFpa7UlcD5O5HF980BTgJWRlfkEVeM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys23jbJId13yDZMCB8/zbhT4c5wb5R9oO2VfeKVpPHNzCVgMmY
	fnv46/Q6cnTxOf8f02g7gUyTypKrs69lxCV9kqG22elMGPUF7kAGRyilDM/ElOR476SIw77jiWg
	W1QFy0JEMYkTMY3Jp13SFJwIpdagE0akhhrwZBtBFzw==
X-Gm-Gg: Acq92OHv0Zxd8dpYQkd13lwFeEUW8KNe67hkfKRM15n6yW86Pc029js7Ld/h8Exm76+
	00d//g8GXIV5AsTpHicC2Mz16zEs0+UtZeaROCBqRlN93EawRb+WdrL11Mx+X/IL+/10d90WGQm
	hHg9ebhHTIbD3BAYJymN5iFRMIQL4etpuJzAtQTT82a8XKJWGNMOe9dGiCZblmwu5YMeaThLIZG
	E7GGoahNGFMn99AMnljJXizCSv2EdG397lRgBVs/XEkIw+L+0oQabEbUDzUIN7MrlVNz43N9PEL
	4VDgkSP3jjjDd7pzGIvzAN7lIEyiJ9JdlfBzpoOj/1/4mVEZz7k=
X-Received: by 2002:a05:6512:4018:b0:5aa:7363:8213 with SMTP id
 2adb3069b0e04-5aa87c13847mr731708e87.37.1780645946395; Fri, 05 Jun 2026
 00:52:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511092846.120141-1-marco.crivellari@suse.com>
In-Reply-To: <20260511092846.120141-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 5 Jun 2026 09:52:15 +0200
X-Gm-Features: AVVi8CdjIMoocxeXX9wxrl3hbJOXhNM-L8HUofSHy4In10k5fG4m74-dwy3Ze3E
Message-ID: <CAAofZF4igoVmsM1oJBFFNUyuTXfk2c0orZCk7qvN=LphuO-ZzA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 0/5] net: Move system_long_wq to system_dfl_long_wq
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Haren Myneni <haren@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	MD Danish Anwar <danishanwar@ti.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Mika Westerberg <westeri@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Nick Child <nnac123@linux.ibm.com>, Petko Manolov <petkan@nucleusys.com>, 
	Rick Lindsley <ricklind@linux.ibm.com>, Roger Quadros <rogerq@kernel.org>, 
	Yehezkel Bernat <YehezkelShB@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 11, 2026 at 11:28=E2=80=AFAM Marco Crivellari
<marco.crivellari@suse.com> wrote:
> [...]
> Marco Crivellari (5):
>   ibmvnic: Move long delayed work on system_dfl_long_wq
>   net: ti: icssg-stats: Move long delayed work on system_dfl_long_wq
>   net: thunderbolt: Move long delayed work on system_dfl_long_wq
>   net: usb: pegasus: Move long delayed work on system_dfl_long_wq
>   r8152: Move long delayed work on system_dfl_long_wq
>
>  drivers/net/ethernet/ibm/ibmvnic.c          | 4 ++--
>  drivers/net/ethernet/ti/icssg/icssg_stats.c | 2 +-
>  drivers/net/thunderbolt/main.c              | 7 ++++---
>  drivers/net/usb/pegasus.c                   | 9 +++++----
>  drivers/net/usb/r8152.c                     | 7 ++++---
>  5 files changed, 16 insertions(+), 13 deletions(-)

Gentle ping.

Thanks!

--=20

Marco Crivellari

SUSE Labs
