Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1053DC4B6
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535601; cv=none; b=hl06ykyN5MGjpPFmZN1T/lYdLXOj8ahvfTtWlTY5A9VhLHiHf7BiWcCZGX7MJCvYlpiWGNUaHJkXYWJyL38/J1GASRg1izbk/lEpsrd2KTz73z00Z9bQ2wWxuNQgaw2c9umOdHd2YnpG0jC6nAayYCd3vmhJPfwW/+wviyo2S30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535601; c=relaxed/simple;
	bh=GByZ08qFPSVQ2Pp57befi5j5wUjE7SDpzVp306QsXF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hdie6kq5aWL8ZImht+7kY7rJbltHljVwwRIJ4CzH4pjlMcRK2igECj2PpUOpeO2vDhVBgxqzrEG1a3qapkGI4MU2kcs4A/qxAprclGsqzupBAEShdS6J/c7hsUDoZ76k0qA23Xx4rmOfW7F+rf7gvIa63tCzI3BzSLgeA79M0bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=KT2Jf3VV; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="KT2Jf3VV"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3115c4451c8so5305521eec.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 01:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1791535598; x=1792140398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nl6lGsMqVBD+W3REigF7CuZcaNchMe60i3xLXWgAPS0=;
        b=KT2Jf3VV+Ku2Lq7YfETGfHTywVv4kBVMSYilCVqRRqwm2hSXPXHoYEJ7DpC0bg77Ak
         9K8pNSyrGp1pWVxgsBZbItXnQlvKzrJCfXQMxiGplmWSUfajR4C321Uuy0wi8e3QYqJk
         BKs+rybuTjzp5WsKs/DqK4vqLnNBxjn2FE56zPIWtyZTgGf0kQ9+paKqTKzua7lwSdI5
         4SeZ0RI4ZSEl2C8D8wTygQQkAEfx4lkB2CpFK8+Cses6cJ5HKOfSdfzfvU6h3P1jNYQi
         sP7jL+Z6MQAdXT3LA9JLhXtWZivJrpggGFZymDHHeMOldq99ml5ryS++iOQEZWd4doR9
         ENIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791535598; x=1792140398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nl6lGsMqVBD+W3REigF7CuZcaNchMe60i3xLXWgAPS0=;
        b=oAgAccZsirz3uh4TZlc0Vbby+4C7Rr4/gdU1fzMwruaV3igfC/+z9dBe5H2snZdRUw
         9+uS6DT/dK2eyyIZEdxOvoiVFFiYtfV9Kh/hZ1nbMlUfqo0GQNM3d5CeyOtiuq0ZtijB
         vgFTKlVrkLM/KTbodPkVuuekFW5c6ak+nxNiLnnbnBgJRYI07aUoFXGoB4wJz6tWOSh3
         /0F+3eXJ4wYNwtiFJ+apzDjzqrDldgBcZ905lx0oXB4tthmx/IacXXGkMWCa9fPjvXDb
         fJAAlLIAY12Niiuaedh5ImIqvMO0M1J+bHCDSxxcTbElNG2Io3jnx5R9gwjMrSAwOskm
         hTMQ==
X-Gm-Message-State: AFq9FYKVTGVwQVOsUy7iJ+Js2ftgJhir1rdUwbgnV5gXNvtC0D70RD8Q
	qaqrVBHzY5ZoRO4y8YNV/ZlC4SI6CXEeDxRqudF2Hk7/n7/KhZkXubnNcv+F4T7BzC4PKZcpJGM
	dfBQDval4P2r4DMFOrI8l6csmvQEiz8oEgx1Qv5oj0C6LHi58ebIK6XYFPuqw6ICu/0fBFud4
X-Gm-Gg: AYBFou3dbKAujuVzFzekjeYB3rl68fPYdII0kcBfxqK1NWo+f0NVMnpoAXeP01jMrEg
	a62A5a+H9IrrnNGnTj6NpurC5MIXgyD82bq+q5k4N+99hLC/aCYFRXRngTZk4n9cf7P262zpqBI
	/EF9Ev8LWht5tkagbu9UTv5Q1aR2MiYvaDQzcNC+zc0pv0pIRNGmYXoBSyh6AzUsSFChsp1n0D8
	RPzetcfeKKxXOrStcTkRier4rKWqpDKslWBqQ44SuDSPG8ymPqfRajXWOE7e4FlswieI6QS5aCl
	75kBoArvndkJ7kgooPbuA7wkkVTqRvX4a6+SSmJLmbBn6VQdnXT+n39bdFNxcixqlL84xUQv7yT
	BREhKy9TzLVkihITy77iGT9lVlgVVZO1CnXdKkzZ5k93Rv85c8iOPx9RdVLhYj9EH1QSHdZlZKf
	UH9kvmvi/YiIEnp7hd3OT2F4AJvULe3JQg4V/HHWUeaxDeDAjiYsaFX1kUCxQUHfHT1zZHDGUcM
	ErdXEEbDas=
X-Received: by 2002:a05:7301:d198:b0:354:53af:7f2 with SMTP id 5a478bee46e88-35453af114bmr613530eec.11.1791535597166;
        Fri, 09 Oct 2026 01:46:37 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-354a52463casm2088166eec.22.2026.10.09.01.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 01:46:36 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: Wang Zhan <wang.zhan@smartx.com>,
	Paul Moore <paul@paul-moore.com>,
	Eric Dumazet <edumazet@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-security-module@vger.kernel.org,
	Alice Mikityanska <alice.kernel@fastmail.im>
Subject: Re: [PATCH net] calipso: keep BIG TCP payload_len in calipso_skbuff_setattr()
Date: Fri,  9 Oct 2026 16:46:16 +0800
Message-ID: <20261009084616.139462-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179147330473.58090.15760316487710432833@gmail.com>
References: <179147330473.58090.15760316487710432833@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 08 Oct 2026 12:28:24 -0300 Joas Antonio dos Santos wrote:
> @@ -1357,8 +1357,9 @@ static int calipso_skbuff_setattr(struct sk_buff *skb,
>  			sizeof(*ip6_hdr) + start);
>  		skb_reset_network_header(skb);
>  		ip6_hdr = ipv6_hdr(skb);
> -		payload = ntohs(ip6_hdr->payload_len);
> -		ip6_hdr->payload_len = htons(payload + len_delta);
> +		/* BIG TCP packets have payload_len == 0 */
> +		if (ip6_hdr->payload_len)
> +			be16_add_cpu(&ip6_hdr->payload_len, len_delta);

Hi,

I think there are boundary cases around IPV6_MAXPLEN: growing past it
can cause payload_len to overflow, while shrinking below it leaves
payload_len at zero.

Could we use ipv6_set_payload_len(ip6_hdr, skb->len - sizeof(*ip6_hdr))
to set the length here? I haven't checked the details, though.
