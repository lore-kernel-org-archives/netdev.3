Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB621474CC
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 00:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790900250; cv=none; b=VWRChAlBnDQZl2RRnsUAxcXoH0nmT4K+K2vz3I+Jq/zi7vvpeVfH4REBKOcVtDR3T8uQFRGWG1CBN4RgT1VBXchHh267YgnrpI3Ti0nAJeKgwkI+400xVjkp7KrTPL4Jwh35x4XWCoHztetM+GykJNoxSnrj9zT0b0SHMPo2dRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790900250; c=relaxed/simple;
	bh=uU8ecgL9bHXX7U2HdHoZ1solGVk0L+qo7jnXMGu7ZxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXAaw96FBnxDfTaWPBtZmg57IpCxS7VlG6NugJhcxMLmgwPinoh1mK5Dr4pHQQlgsHp68NUm6+Fiux54kho+QUUmxaybhk1GA6EhkM7gHYtzx2BcLI5G98wS4V3wpkU6O8051M5dPBbDeRNycdBJpbqwy19IPSaFHLMYCWwMYBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHE9iquu; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHE9iquu"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912e4b11so42662015e9.3
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 17:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790900247; x=1791505047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=px+/xLsiECPGLRTHgt+4dAM3tfLMzLHXRYmynoZyTdo=;
        b=aHE9iquu/43JCktzueIIzn+zVCXhxrigI54P7qWXgor62VIVbfCY/jEY6g9wiqNLJf
         LK8FRpabV89BTGKyadA2SUBv4qgUHjx5iMxUULqxJbia/pvf2EwhC+0hX4sXvfY5ZyTU
         1OnIyjdt5XCLACOuleDujHggsq7cx5zEguVdC+v0910mSOif1vdRxKz3m92EVmL+pXbe
         MqJoTBN8UwbngR8GKWZdJ2DFknGHi9ioN1p1YtkjdEx6GQhq7/AVN1e+xTyJ6J1tnoWY
         JnoMy40o+cNzH8ZaZe9+833m1QlrtFl7Uf4PS8DHgZhJ4AqXgRii+X5lt8KibNVLny9Z
         Vf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790900247; x=1791505047;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=px+/xLsiECPGLRTHgt+4dAM3tfLMzLHXRYmynoZyTdo=;
        b=qZVYvqPyv2O3zlgln4XewfKJRYqsx+msuM/0SH2PryJ5G3WJhQZ6VKueACKZS0e40R
         hMY9tIC7q+u4FLX6UyLmVKo289Zm8gvGLsW8VxrKq4v6mtL8Gm5pQtfyV869nnecECgA
         w2VicuEReVFSPC3+VMKCXanqg6QjRjCOQUWO01l9T4UE51Sp8CjOMyM9haBt1sgcvNx5
         /2P2c+xJmbGINjf627RDuUBDC/fKkc3sjrLdfNJ1Byd2cfailJQ9n7rEinsyS3gByFoe
         YKQLLtDeRBMPf52ad6Pqh+lPmi48o9cu3lAzIqn6SF78u6qKWmqvKeU2y+HUTm2CNTCh
         yRZQ==
X-Gm-Message-State: AFuF++koNHVx+lSV4h+H1N8M0/PJNEOVLIAibN16mRA+DzdxLiSO1iex
	svpEN5sWeglkD/WfuQdyMxf/btDyH5Gwprl117jdO8/cRm/OCyas31yH
X-Gm-Gg: AYBFou173/gp3Y3m7ePDdSiJExBXtnr8XTAiRgxHwzgzkL/PabklG3Fp4IsCrV03otU
	KDp2t77Yv7DCCBhYkBEBhTs6PpVcJFWmcFUxwB47PSGVYDHURFPCp3KDNq2EMETf3uutex2VwN8
	2E2f/PbjVSvWUwdOhxkQLrfuYIOr5jQvrREQ+hSUXzbgEJGHK4bULTEoAGJ0rAdXB74d2GwxNCY
	t1KKkAjHHbM+VfujbEmipATrqf1QSeJwotIbYI5+thXYYuOvgU9i7RKptWm09tyUbiVk3ZkweFI
	W9dg6gC9JU9d4Lg4bvjivnVt7EqUc/tzqOPGrCUFu9VmuN+E2iJ1+3wkVqAtR5wUVSSxSmnTxg4
	MBnvPQ/hGqniWm8JBvGAxcypXK4u1aP2OG1hVrB0vB8n/44uaqQRiDsawImLt8+T5GnyLBXP6vc
	VuDU3XyNI72znIdrcnFblg5MuQRxZABGEZBCCFCdUa7vmnVkbC3HA4LT/TOvoHZTPwG1qMQZ4gI
	P3zgoGIqdGbVVsOZtyGZz0nLZzO8RPWoKItch3J5yxygQe3rlU/OeVKhbj0U3tNaJD71pcTGzWV
	KutrsCCf5LrV7CjfJNSS4muhw8/Xm7e7ClDyaKiT78S6dqotgnrKyadUfWNvPPW9+WEWWMBxq50
	Rz0xQWTp/+CnSAPMqu9UJ
X-Received: by 2002:a05:600c:45d3:b0:49c:fc6e:a3e1 with SMTP id 5b1f17b1804b1-4a0276f556emr18772095e9.32.1790900247466;
        Thu, 01 Oct 2026 17:17:27 -0700 (PDT)
Received: from MBP-von-Karl.localdomain (dynamic-2a02-3100-b3ca-3a01-3deb-81e4-0dc4-fbe8.310.pool.telefonica.de. [2a02:3100:b3ca:3a01:3deb:81e4:dc4:fbe8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03048abc9sm7487875e9.0.2026.10.01.17.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 17:17:26 -0700 (PDT)
Date: Fri, 2 Oct 2026 02:17:24 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] netpoll: use a raw lock for the deferred
 transmit queue
Message-ID: <ar73Oi6r__PY-RE1@gmail.com>
References: <20260928064239.32456-1-kmehltretter@gmail.com>
 <20260930192103.62973-2-kmehltretter@gmail.com>
 <20261001164355.212c8ce9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001164355.212c8ce9@kernel.org>

On Thu, Oct 01, 2026 at 04:43:55PM +0100, Jakub Kicinski wrote:
> On Wed, 30 Sep 2026 21:21:02 +0200 Karl Mehltretter wrote:
> > Fixes: b6cd27ed3388 ("netpoll per device txq")
> > Cc: stable@vger.kernel.org # 6.12+
> > Assisted-by: LLM
> 
> This slop is definitely not a fix.
> It never worked, it's net-next at best, no fixes tags

Good point. I'll drop Fixes and stable and retarget the series to
net-next. 

But first I'll wait for input from Sebastian and others.

Thanks,
Karl
