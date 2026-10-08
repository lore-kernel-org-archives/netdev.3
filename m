Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1471A331ECE
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791468968; cv=none; b=uUjj3uyxMxMA7ozI6vjpLY65IXm7KF37OUmqHU5YrSk8F0lHNcAjJzHQBqN/KkQUgAk84yg9Gt46gocv65BZb5tx6DQN9WraESwY88RB43YHYyyMA4KQ93bnP4EZ5OClXVDpxxYGEJxzRU33DkNZ3EHizJXRZB9/EB0C4Q1pG+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791468968; c=relaxed/simple;
	bh=+t31azwcCJHg+PTdel+R4blWILgZCTTuWf8AH++/aVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlBdCTxiD+H/Bqf9HkA8r2XW+hnOnKSAdrjTgreI8cSrFN0kw8Cbl/htKLZ1LItyjyXzzjRk22+VVArhiNqJuZevhTExc5oIbAmUGKADq+sLUqIvnaI5bc6CkHL4/siis3qvcnD7Y9p/UQcE9+05orZQg7Pmv7NREhXgn6VGDf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=myGPmTC3; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="myGPmTC3"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91951405546so60013776d6.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 07:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1791468966; x=1792073766; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D3W505++mGs3YgmeV426L8BBID4lmqouAVUZbbYJa+Y=;
        b=myGPmTC3ygLdQ3LrYWuEy208LjDEklIFdgGEbtLQQOJ6H2QIpeLei+Q2hat92s9+QI
         Iuh/0vTpd/T82LgeNjiYuuSLaNuccrkoQ4lh5NiwiYF2LFfsvaAY9Y0Owp8etbCyMJCN
         CZBPONjJIfHoIwSu+bpsmdysBPD5Xd90c9XE6feu5nFAtzK5BIkldLdwsIi7dRrKvgbX
         uI6fYL6Qmo7Dyfxq+JylRnKKTS9yxvtPJQ0LLlX1Gln63cZfMW0A7H34CtWKihKM/kdp
         itVfAlG7FMn2G/p+0D/lV/9GzML3pgvz7PJEhi4hpZ6vZNLLjwpO1juCw1oMwmalCQ/8
         0dJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791468966; x=1792073766;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D3W505++mGs3YgmeV426L8BBID4lmqouAVUZbbYJa+Y=;
        b=Hyrcl3292CsdtEBx3N9aJGBu9P8W4mlfhXmMMQK6P2vhnvi7mIKY2xepjoWay+yliF
         DPPueT1QGddm9tQGpmMNF/DqpLmxXlaAgdmOYBA7hrlDeKDmE+UGMg3x4FhypkH/ro0b
         kwSPy+Xh2bxVfgVEpbSPZhDXWRiL9ot3owRsjS1vAKsgTx+ELn4nLtYJSbFm7M9/YYVt
         /VE+T8reWs96QkFZEKRsa/kD1vICwfQwtrV7PNw/29E8f7MpyhXyQ7rYqzNWqAe3UyRO
         v+ovtJwRSZyHI5MvdKVg69fT3PrDn66eVg8nusOhm6uUvaLuukIWKxkQI1Pz63ahwfcO
         s8zA==
X-Forwarded-Encrypted: i=1; AKwUvBw3ZoQZlVfQZLvkfhI+N4W1lga/TeMXfQZJ/HTYP6oMWse6Gmj34p3teEnYptVxRAuragXo6dI=@vger.kernel.org
X-Gm-Message-State: AFuF++kwVDrh+FOs4ruEHKr4zhtGLS1J9UW11nIPKYqrTjOA9Vaoi8Fa
	J0mtH2l+9tuReubX3YuIodO3IYDVQ1EHk9EiVnNR3rWWh+eqOk6ni7Wwzqnfabbx7A==
X-Gm-Gg: AYBFou01o7Z4t9DoENX0hFIf2jZ40eijoxpklMX+Mf8oXmFl9OxlrX7zei2ZHAmnvnb
	VznQ2KTvxIHZYBUORHq9ZtWt8gLeWJ7UePOXsQ0Cun1DgGaAO+P1d7lvy1JsokIvd+tyJ1Ixfnl
	u3ChmPMIqxo2wnOrkFYhS+S29v/w6i1J1LoDidFvU8Kzw4JN2kKmiX5vn3azn2xiRbD1/rwK8cC
	rRGJ0aDwQXrApCuP96OejIFwetHTzn6TnHNbNVIlXra0gjICbo0pHMWwKhLnf+7LQDBU4FV+tBv
	FMIdT7/jC5FSCq+3OG76n/PbLwdTAQUqAZmyn671NNPsjiPcDGsQC4by60Pbo0PRF3dMztKn8S2
	r/Pe5QaGDDssIwaBXtSybjTZJT4mwMETAnWcROUQowGW9ZrCAwTYUGsT5PizNYTlUm1F3hqkj1w
	ZN141s6KtFuAxjEyYTgInhFzSOkdw4SQ7+PRsbPlpc/D7be3cRjbuVfjiWnT2NEqKObDSF2Jstq
	4HObxLo24X7UNM3
X-Received: by 2002:a05:6214:2408:b0:919:952e:95f7 with SMTP id 6a1803df08f44-919978b8a53mr106709096d6.51.1791468965565;
        Thu, 08 Oct 2026 07:16:05 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91996cb5517sm48391886d6.15.2026.10.08.07.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:16:04 -0700 (PDT)
Date: Thu, 8 Oct 2026 10:16:02 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?iso-8859-1?Q?=D6mer?= Mete Kaya <omermetekaya0@gmail.com>,
	oneukum@suse.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, david.laight.linux@gmail.com,
	syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
Subject: Re: [PATCH net v6] usbnet: fix smp_processor_id() use in preemptible
 context
Message-ID: <7c4a2f1c-f16d-479b-a11f-cef962d5e2c7@rowland.harvard.edu>
References: <20261004215937.302247-1-omermetekaya0@gmail.com>
 <20261007200049.079aeb75@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261007200049.079aeb75@kernel.org>

On Wed, Oct 07, 2026 at 08:00:49PM -0700, Jakub Kicinski wrote:
> On Mon,  5 Oct 2026 00:59:25 +0300 Ömer Mete Kaya wrote:
> > tx_complete() calls this_cpu_ptr() before disabling preemption, which
> > triggers a BUG when running with CONFIG_DEBUG_PREEMPT:
> > 
> >   BUG: using smp_processor_id() in preemptible code in tx_complete
> > 
> > Fix by using get_cpu_ptr()/put_cpu_ptr() which disable preemption and
> > return the per-CPU pointer atomically. The usbnet_skb_return() hunk
> > is a hardening change: that path runs in softirq context so no warning
> > fires there, but the same fix is applied for consistency.
> 
> This looks odd, how did we miss this for 8 years.
> 
> Greg is probably busy, but would be good to get a confirmation
> from either him or some other USB expert that the callbacks
> can indeed be called in process context.

They can be called in BH context with interrupts enabled.  Is that close 
enough?

Alan Stern
