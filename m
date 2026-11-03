Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694151;
	b=G+uUFSj5o4MramBfdPn+UHde380joAtec/fGExz34RkKIEPY8YTWMH/+qWuNq8FPuqf3
	 NovfFm5SSY1Lwhap/79i7zPRHbZOZj3xf8SIwwQU006+InvpRKsEWcMWYDKIeYXU13HzM
	 Y+9RvnMMIBctduS408sVJlCnO2cbB0qg324ckLw+RdCQG13EWjyQHIYGEET1jJu5q0Snr
	 K1uQAtk6DZrF+M2scbKczPlijrzRSUULtUN3/ZsKpLFcVj6cGPflemf0I4Tb3BHr50rYI
	 Y8sxR/qckMo+3xj8aVLVhg2omAOv1F/VBBw29EAXQ09FOYATH740+2lMARosHZ+LHgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ywEpiDPK4X4lwtwqfGUxqJF97k3enH7AorttNznK9fM=;
	b=G1GmlOIqzAlopSXDfaPrbqxYZtepEubZjqRt+iEaEphF0COBEeTfzhS9wjJRjXRmJGcH
	 nleAR+NOgMrX0aTZ3BxgWDR4xYfkWOM8iNa0PMZWpzf2VBlhSIaP6tVJhbrGXKJHha08Q
	 G1t+Bx2/YjqxpuXyCDAp0oqro4F11sAAodS250Izmlt/Vvo9maclQooTWWSyfJQNmuPIA
	 KyzA1IhU3a7VCvTtB5aYJZWYOtgtkDR47+omnAibVDefNUeMNfQvTb++4UrBXssC3T8ha
	 z1w9lfs+tlkQvheVs+5ZrTT2LcbasDFxAx4ap5Zqt7SO0PdrV6EoWS/aiwyX30uhzdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Vb+RDi0Z;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512A9606A329
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 08:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 512A9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Vb+RDi0Z
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48df4e9d2d4so2049084f8f.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 00:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793694149; x=1794298949; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ywEpiDPK4X4lwtwqfGUxqJF97k3enH7AorttNznK9fM=;
        b=Vb+RDi0ZvJcLQv+YaQuOnDH/hs+afajV0HP9eGbv8wEvjgVDVTEv3v2q6L9+2fjW5i
         temELTC+iAKXODYvGzIstOgV5u+HWtOy423elq1hrjb5JF5lkma4HToNgh9q5cBHe+Xl
         CK/3u0l4cl5m9m+d970COeXBSq5CRBcFxhKwSr0JWwZh2VH1sf1UysBi5ReGYIEA7qDA
         lCcQXbHaSPlQd9Ni3Ch/Q7isklgnAWb9atdpyMWXk1UjCdqB+jwH3sQOJpt2FIE5tffP
         t2JEHtfuRee6qbIcPeWidsLgHDhn8ZmRruheumVreNsdwBoQwIc1rrY+PWfXzGhbCy75
         WG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793694149; x=1794298949;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ywEpiDPK4X4lwtwqfGUxqJF97k3enH7AorttNznK9fM=;
        b=LB7RSvwxVEUfFhNw+nKjVGv9hhfB8+mg4dJxJ0lVBkwijbzKJMY1ROwf+8jdKes8gR
         lxFRXiR9VErWyYbQ1a2OjtIxWIzPnMHZCydENCqYzikcgcoNryl/b8q97StGtd3AEPoh
         9DL4+35QDBSPcrVlZwuVbTkxQVom18Q85EhE6AMcX+6wfGAbQe+s21cNbo5qe8VbIa9d
         mc+eEbvYGbnrVO8XJm3ryeDqNCevWVPqObAILMjGECy7bizk90m5arZtkkcxGiheTXyj
         4Lylwsm5/kUWnyafexFZcVhPPpUUcoDBe0GtF4beyClxRAAfaLL78CXn032yqPAEX6IH
         kiXw==
X-Gm-Message-State: APuU4Z+Kio2Uiqz+D1fOrF6oGjzTtI0ZHr+BceL9gyR0uXs9SsIgCJYP
	3PaO2CygglHHkEiO2xWAM9JZJEFDa+P+EO/tYxAWdB7QQG7hZpUh8vzCBEN99/yuxEU=
X-Gm-Gg: AYBFou2my7rJXSWcJKG5lHUROP5n4XVjSWIkB4zKQ/ailRkLjHYu/CnlF3wdzsO2m1e
	FQy3/HkT1yn/eQUGJocC4FmNWrHkvDK/N1Pimf4MEnsIeITaAVYCJ81ggHYPROHXLfvTmtM5tSC
	Z1xB9loyOYAgn1Nzp+Fhs4p9P7CUM4s7v2JU6oVVSCqD0p8gZNALbbN1cqOVMYdMZA42V1pAaYs
	j20q/xddbB57qwHRQT06q1XjP2EvNln55OSHi6QhUOw0jVai6WiUFIwfRIAILp6A4GpOoK8Zklq
	PQJmPyj5pdk2C/Od86Ot2SwbDZ3sYHrxu2sjJLCXIWWFKGfpKrOlcifWfsITjzuGpx5AoADa8hP
	OI6vP/v+NVHkjFf0Dcap2AIeg05Rv+D+JMTlbRWVW5LEPJvLvFE+lxaEVmyigStMxzLxD/kq1jg
	7Rx5i3ACzgrjHa8l3gKHlMcdwqAtia5/V0ba5TD9JfGM06NWb9kWfwgA/ce6H0ByBQN3ZZDkvtU
	LFY/FeVAf7dJppP4hFmWt5+admtuEAr5WkIKfhfuf+qNc63UHafeHcsXtS+1PHyMCSC611ix0pW
	XL3g7SKwNhVcfTCt1k/j0K+MfjN866S+04wp/vMEk9xOnXIYByfW6gsUdAG1puAISjOtQZk0Y15
	abAyoIEPl6KMjYfY=
X-Received: by 2002:a05:6000:4312:b0:48d:f36e:fbcb with SMTP id ffacd0b85a97d-48e6e2eb205mr29662965f8f.14.1793694149346;
        Tue, 03 Nov 2026 00:22:29 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be. [194.78.224.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b7270asm23867730f8f.11.2026.11.03.00.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:22:29 -0800 (PST)
Date: Tue, 3 Nov 2026 09:22:26 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 bpf@vger.kernel.org, dsahern@kernel.org, Willem de Bruijn
 <willemb@google.com>
Subject: Re: [PATCH net-next] docs: netdev: fix iproute2 process
 documentation
Message-ID: <20261103092226.2e8ab229@stephen-xps.local>
In-Reply-To: <20261103033611.949104-1-willemdebruijn.kernel@gmail.com>
References: <20261103033611.949104-1-willemdebruijn.kernel@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Nov 2026 22:35:56 -0500
Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> +
> +Patches are tracked in patchwork under the netdevbpf project and delegated
> +to 'shemminger' for further processing:
> +

Minor nit. David Ahern (dsa) handles the iproute-next patches.
I stick to only iproute. 
