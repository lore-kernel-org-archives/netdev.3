Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794433310;
	b=Y/oBBT/fgOqROTpck66/Vm6nNA/PCHXD9XnGy1Bf2eZzU6bHsrWSN3sfpVg+tXpEnZYD
	 kYgHqYaxT4bhhJ2BEW4srVSy2I1HS0J/MXcuBvgH/cTNYyTlqucdflOiVN6wA1TrNjqNk
	 Oo4Hh3IC+fJfw+smww75lWaKYyezjLUFphxuajZf/Yd4Z5y/Kgs8R4abXMCvONnY6+buN
	 idfK9kSnkP2VS27DkotK6CCffkwSLCTPWirpzAI4ajQOUsy5iAQQyEbT4tG1WxbUfiLjC
	 X3mX12ozDzyUO7WNpxGmT7XtPkckmBVoHrs04MMFcUz3DTqcIvfDh/OcNXJUGsj+4EQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433310;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=I3NsBH7dbDhUWpFoVCuwiBWZEyjMNzIdlKNXXp/dwQk=;
	b=5aQdjqRGw9ibxRxasC+1ff8rr5ZhZ4Wp6KYzd7vYfIzrTg2J53hVRADmiqUGja8DvD1E
	 nNkYBpWmOmNPwtrDQfZheO7oto/6GRXh0DEB+P4y2Xmw6aD7mbaAhtEgpgIEHuNDxc3vo
	 GRm6zhTJnCXrDD2sa/oUoZOAfGjolsqAXOmc14RBNjr456rG4+k00o81Dl+X7SKf2gD/e
	 KzmZ0bpFGach6Z3cZlFWy7NKvm45XeTbfClySBWGd5i1KQt60NIytDlzXx5zm4QH2e6oM
	 Cy5VyoqhHNwwgEqxAI6Es7IDzKQI4dgJIPRfO+FEK4Zrj8eBNxQAouWHDDMO5Hp3mfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=F4Iqknel;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48560606A326
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 21:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48560606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=F4Iqknel
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6fe4372c5f3so2074387eaf.3
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 13:41:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794433309; cv=none;
        d=google.com; s=arc-20260327;
        b=Dp8iHIUFlpeEu9ES4LhaFguhT+/7bdKNa8zrWYcvdm5UzHQHshqtAyb39EEp7YtuJz
         w6o4bItBu+/W179/gf4wqNWwdXgiZBsfRWuxaIRP00kj5z7sT4+N9Hfo+st9vTC4KqVu
         qm9ZtSc/6pzhlZyj24ZZdl2VX2F1/jalqcfWPDxTdCYrjAmJkPa11vWmlTTWSkpn8gq7
         ElReGkscVj7DVVc+1oqXDBBYeFUWjH6PV7BcrwdY5CDE7/S65PKZouzOCbhFQLzM6CWB
         NCOIPo8YlsxYZQlEP6Ve38xmpxIpbVD/lZpA94U9L7buPkZUMlh8dqwqjpb5iEoCEBNX
         f40w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=I3NsBH7dbDhUWpFoVCuwiBWZEyjMNzIdlKNXXp/dwQk=;
        fh=pPexfLb7+x9lBhnbozZejMwxPcNKQ/0d1OQhexmwsbg=;
        b=rdE49SPGoMo8r3fUUFJIsF79A3/lfgDAyHyThDnw3/KhtPHZ6N+y0EQB8/o2dJg4Se
         Hb/RPgFZfXms323RQpXG5sbEhED0CvEbOGh5ExXHNam12FvQ07IVLef5TzulPDAXB0Wj
         NRXkKt3EhsNSwO+hY+WgKbF23vMxRP9+f5ln85DToZYNeqA1Nsi5VVs37cZ78ay778S+
         +xr+OFv70OIJ++Lz8flh/0SfzL244EuZF99OhZMJjaxiQcxKehSu8HMgnN5KTF1nkApy
         qyunrbr0yat6hyyt3YxHYI6chFD8jOGCMP0jjUWCWwwnA8E8pbUnqQNJuT8F08PyTWbu
         sdMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794433309; x=1795038109; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I3NsBH7dbDhUWpFoVCuwiBWZEyjMNzIdlKNXXp/dwQk=;
        b=F4IqknelR9U1Z90dhMwR0D1pwxqtvZB8DQWKsM/7pekMNvXH3BUQPt18aS0+PmM60o
         FmOlo7M3dSJEGVXBSRxxFZ72Xpju7KdBtpDEBRc8cRLSsHdXEHOfO05mkyel7IqTfSll
         IKkySwdEkEi1fHjMI5JzdxK+ikucIaoJkH+tl9UetAAXs88zGYQwEHCUo6ycT+56wnN5
         aHfCPaV7zf/R6JzzhuNpccH42WKrl5Qmg2dPkCPFYGgPM0vjObTWRnccnQk8gREUwund
         95QJEfY8ciOcidLK5/u0kF0O9RWV4PH7Iyr59LtTkFj5pS8lMCbuwP/9byeDXW5kxxQB
         o/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794433309; x=1795038109;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I3NsBH7dbDhUWpFoVCuwiBWZEyjMNzIdlKNXXp/dwQk=;
        b=1CAlO37ahSq/Ww/qaGIu3Ycrs58k+4XNdxojuZ0pl4O1/1CRDAkQZsjxwhTpwbacMf
         oS6uAH6wlgf5pXnoqlofbB2x2OcxrF7956WlWeTlw+1KpduZNZwK71duuxsyTLUP3VZ+
         7NO22rlkjhscf3Lt7NEKrNnqJ9FQpRtKyANWxP4o0uXcZDviMfRQ0akChS6+8QBkcz4X
         XWOviWQ3OSvs4NzLYwPShxha7/3hIb3x/JcMxWOOqWhjZ66VYTgnFmMzLuDW9EI6poSQ
         xSjhlTJq+YNRcfAkUYQToILE0hiIZYnl0OOHr9aV7LOsghEgZ4F6MkOd8TyFdmrcRh8K
         d35w==
X-Forwarded-Encrypted: i=1; AL+hErF9ckBO0SbxhcfEGz6UgT5ZVU9IDmo+pVmlGDinwijC9WkJZWmf+3Ow7afK3z0LUdpvJUuhvio=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Ud/DrQ/X5nNBTa/gboAJ3LOJN84ZqJcJHLnURwAFP28vJJdrm
	nwP4pGN70z/4Gte7CJyFoe+9j3kFfvAtvOqMijkvq0bONkH2XeUvzrqV61gMndbktg/LHu9+KGX
	258gyH4rskIY87A32zvELPch5tnyXZD0G7UW6nM9aOg==
X-Gm-Gg: AYBFou1EsnXRS+fDYygMPK+X5GZFb6hAXDmmY+ADwroHBI3RnXYOn098bJVrk8pUopt
	ahhARtrWQaRB/bDqefOxQ7St+Kfmv0qhFI22il2FxMsZNkv/SUrEYlQtnXYjTBEuwJPx9YYak/R
	JHmQn36Ok3m5w6eIFY4+Ww6rRzo3tQvKzolhtel5eDALMkqLYKrV8yuHYEzwu+WZm4iu63fuGo8
	4ZcHL1CIdediNkuhqxJR0FeUPpWyA2yF0IpxPgBq26qL7z3Ir7G3ZEU10MZktF8OdMEjMLMrDER
	V+eClXhf33+8Dn3V2CMnbVADf+RG2d1W+ho4SGF8E0W8h0LaYauGIQhjSOMqorhw44ZnEJaLCc6
	wXd0VUF2mbu1+eMJpKcPBDq9kkao47ggMbhEPT/bHrdX5q4pxJGVKxGPn225ZVXkNBllwBzGS+0
	MBtt/YSQJBpg==
X-Received: by 2002:a05:6820:441b:b0:6d8:ccbf:a7c2 with SMTP id
 006d021491bc7-7191797df4fmr2278556eaf.68.1794433304290; Wed, 11 Nov 2026
 13:41:44 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794020868.git.tianyi@cloudflare.com> <e90e748e0aefa7cbe1c2b31b8c7902ccf135c3f2.1794020868.git.tianyi@cloudflare.com>
 <willemdebruijn.kernel.1d64e7848503b@gmail.com> <20261107182526.69543-1-tianyi@cloudflare.com>
 <willemdebruijn.kernel.2c6a653eb65fa@gmail.com> <20261108190831.3f991a13@phoenix.local>
 <20261109154909.32748-1-tianyi@cloudflare.com> <avTOvr+yy+2j8xrQ@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
 <avTSBFpR2t7PO9tx@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
In-Reply-To: <avTSBFpR2t7PO9tx@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Wed, 11 Nov 2026 21:41:32 +0000
X-Gm-Features: AclHuK9Lzd82c8LN3lRJw2ClwKtYPqt-3w9VlW5CxKeZCzjufsRqZ2sayCWq8TY
Message-ID: <CAG4wq-d+LtEi-omGwzgqx14rCp_4J9HztGMpa8ioMsviaPw+ZQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/8] net: add tx_extra_headroom and LL_ALLOC_SPACE()
To: David Keogh <dkeogh@amazon.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	David Woodhouse <dwmw2@infradead.org>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Nimrod Oren <noren@nvidia.com>, Alasdair McWilliam <alasdair@mcwilliam.dev>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Breno Leitao <leitao@debian.org>, 
	=?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>, 
	Danielle Ratson <danieller@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, bpf@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@cloudflare.com, nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 11, 2026 at 08:37:24PM +0000, David Keogh wrote:
> Our TC egress programs are not attached individually. A loader keeps
> a chain: only the head is attached to the NIC, and the rest, including
> the program that encapsulates, are reached by bpf_tail_call through a
> prog array. The head can change as programs are added and removed.
[...]
> For the BPF-side declaration to cover the TC egress case, it needs to
> account for tail call targets. Tianyi, how were you planning to handle
> a program that is only reached by tail call?

Thanks for checking how your hosts run the program.

My current plan is that the kernel reads the tag only from the program
that is attached with tcx. One way to use it is for the loader to tag
the head with the largest headroom that any program in the chain can
push. The tag describes the whole chain, so it does not matter that
the head pushes no headers itself. When the loader replaces the head,
the new head carries the tag and the kernel reads it again.

- The value can be larger than needed for some packets, because the
  tail call targets push headers of different lengths.
- Auto-tuning has its own problems, as stated in my previous reply
  [1].

I cannot find a solution where the value is always set correctly and
no UAPI is needed. What I can do is keep this UAPI minimal.

By the way, I plan to support tcx only in this series. A tcx program
is attached to one device, so the kernel knows which device to update
on attach. A cls_bpf filter can sit in a tc block that is shared by
several devices, which is harder to handle.

Let me know if this plan does not work for you. I plan to post v2
around next Monday.

[1] https://lore.kernel.org/all/20261108214356.95406-1-tianyi@cloudflare.com/

Thanks,
Tianyi
