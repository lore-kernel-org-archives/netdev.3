Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9736943FD11
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 12:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784808089; cv=none; b=IH536lZ8wHv6iMA8Y09Uo8XUS3vCx+kLrlFPeNqoFhNib3zlC1xY/bNyTFGt21pLf5s4hKWrcHr/bPYJa7oENlJ4oEzWtlelMKfUgekKHtPz701oxuH6/m4vd09xJlh1WnYA7xFo+D2b5BWkZTcQZvuXZoMn9l2/uCNEHBGWG6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784808089; c=relaxed/simple;
	bh=VhvXNNcxlIZQB3tmisgrhWDXnzRc2mufK8ra6Ac2TC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNYajKjRj7XrhZJg38RdlJ6FWwVw8khiCxh2NH30kf9NdnaFx6Q1+KAL6AAFSGyQnY0jNycj3HN+5uNOn8wKsCpIa9f729y6NNs0IvgLG5N4kwD7C60bAhvSAJW/sIgxbdDe2AabJ1uzSwgoL40igyuPq4JqHtpPlhyZrFS+8xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=H5mszQ7n; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="H5mszQ7n"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1c52d920b8so80824466b.2
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 05:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1784808082; x=1785412882; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PkrX/Ja8Q0VrDbJNxzAbjjCsD248bt/Vc77qR3I7Xuk=;
        b=H5mszQ7nFu7UIR++BiKmotzfRtStyeBih2LCSzFooxL6HBy2No+WPVBXMDP/95aEOA
         M6GawiR30SnR/BS4gB+muVeS5x8+TeedpIURg+qFx+UUZEyWu8+wdmxhfDHiH5lPrvkB
         U8zYze8jLUcnCCnuptXvBzrNNDQTNmZUo52ZePwQQh8ZObGfHzvPH6mJ3Wzgp3mRjCvT
         vQyXMATOloqDLCyT975fJcs8u6ndQPriaMPu3GB2BToGm8Os8tdD9pX+dtsgPpyqIH9o
         Y5BPPyErXMKhZehX4yFK09YkU+k9eJT0wr8H9/JJNGeb5dZJ35LoeCZIgksS9tECmr+m
         QZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784808082; x=1785412882;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PkrX/Ja8Q0VrDbJNxzAbjjCsD248bt/Vc77qR3I7Xuk=;
        b=kD+esu+Owmt0aqS+ky14B+sNf7xSGLjM1PxQKNwwoWHIXxTad/aPobOgFCyRW9mKr2
         ss+pkZbLEVmb7XQzmgx6WB5s0kQpsuAR8/oNqEXwEvi49efSJSebMYnlTh/FIdIfRRj1
         ax6E4n/kKU/NGJIKhb9pYIusXFEpWYf1NeYXtNYJqdJq8R7D2VTGPw8GAfibF7cT6OKi
         vyUGHeKcTOkr0ifcxzNnOa2VTxmIzK5aKvhVjzQ2tBVxCqP/saQ/y7csXtHGArGBusQ+
         1JAKWBXgR3zE1yLaqMgWdZNLOBi4Aj3et9o5ynhg/vf3FQoR9lI1kPBAu/kzB7kx3zZX
         XFAw==
X-Forwarded-Encrypted: i=1; AHgh+Rp+yUxLj3x853cNrZi22YDrAf+NAGv6vDowGpMmRUdLuVweyUYV3oc1B+d2kIiH56shLo1KbGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKZwUZO7iRGJ8r3R6//1WClJDN+rLL02uncvQtorv5SotPfevK
	+pIGTD1BY8ecyztAkEVCbvoI1EqWkmFH6uZdVtIGvx5C5VH6AlLnqGrNnQzosgfQC7Q=
X-Gm-Gg: AR+sD1078yyFY+Z53N0FAPFznGk50DKgY8ocnAcGpWzszvhDwcZ1CwB/TPgHKOzczTh
	PVdPLgq1c85IIXpifL27RMnhvbMfR1SNLjyeM5XoNu5zRdKEK3zosTNac5XQad1bhWDY001926V
	ER0qyz2iGjhPA5MUThIrU9HXsNu/J56Or9IfcLEIiHrRWk9jEYMBX5wm1Neq7q59+p7oO7RidWq
	Hkt5lIR3QrPkJR5nMFdY1J417KPusQUFQM7NVInPAId8NExTCkQH39ZwQuu4jw4S7IPr9hESqP+
	vVGZGkY5KHGpKuaaPevCS5A7/I0whEt2hQpXiEG/t1H9F7M+5U9J4QqL25ZSZK7Z8lpA+NJ85lH
	YZNVkC9f4ltn5m5rRJZ+aqIQoFSIpvZj08GYUMMsR7tEfodHqqaDt3l33eqyJtyro
X-Received: by 2002:a17:907:e1d2:10b0:c16:61d9:1679 with SMTP id a640c23a62f3a-c1c50992bfdmr78318566b.52.1784808082255;
        Thu, 23 Jul 2026 05:01:22 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:1cdc::2e0:3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ebb98dsm220560166b.48.2026.07.23.05.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 05:01:21 -0700 (PDT)
Date: Thu, 23 Jul 2026 13:01:20 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org, kernel-team@cloudflare.com, 
	Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH net v3] veth: convert frag_list skbs before running XDP
Message-ID: <amICehHZJgV-mt7S@matt-Precision-5490>
References: <20260722191925.2192070-1-matt@readmodwrite.com>
 <C8A20909-E6B4-419B-B6D6-35EE7DE78C79@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C8A20909-E6B4-419B-B6D6-35EE7DE78C79@toke.dk>

On Wed, Jul 22, 2026 at 10:53:34PM +0200, Toke Høiland-Jørgensen wrote:
> 
> Please retain tags when respinning.
> 
> Reviewed-by: Toke Høiland-Jørgensen <toke@toke.dk>

My bad :) Will be sure to keep them next time.

Thanks,
Matt
