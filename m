Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC68A2EEE7C
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 01:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789436784; cv=pass; b=bdi6fyUFOxvc3W8p6ZiYttytil6CydeWDlNOL0NZZv3WHT5n02kDkEkT6aLa+L2p0NibKRQ0fTnIulZl7IXs5QhWpCAaSzKqgMKgKUNtGCZ4/YvXNFFBOpcQoq3ZdzxvJHbfREW59MqcsiEdZ33jcTRmPvwBDhlCMTMS6ljJIJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789436784; c=relaxed/simple;
	bh=e6Rtsf4PevE9PvTtJeXKgCS6wQBFKBQ/vL+iN3PKGt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B47fbDr6hcd8e2+k5O8cObqBwazvOUcd1SGeeWcB/4/wLrmCVTNwGv0tsRnonL+OZ7QYFMGLoEUW8ysFBHKg9UgUjroIKzpQaRCMeYggI1FXRb2F8SBTVt4rR2MnaHIK9cV4LJ7M/WqxINtk/H3HPUw+jJjKHHfA7hxwsSPdtsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9DenRCp; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9DenRCp"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93a125dd74bso196983985a.3
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 18:46:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789436782; cv=none;
        d=google.com; s=arc-20260327;
        b=jsy6i/YJ/0Wzdgd3o+ifZKsoHpgiGXbXcxzB3zjpJRM2yfbAMgSA4cvofkLdlGkI7J
         4YowF9Su6cDvy/VoM4kMeXG7Ly8mr56pZUCBV31hRPJ0ry4Bv+QF47ocIbsmQD28sXo7
         0Rrl4yTrgcBQQ0eY8YFV32KzGOvdYKWBA2BIZ76V5gkykoo19mjW/mkPKB2xQlUn0OVE
         TiR7C9StmOGfjC5qBe8eQEotZtft/rj+0tai2grAdgOVTgKNFSC5E5ciAsZh6BIk8IfG
         Iu/t3FQObnI1oew7Jy5O4f6b7x2/h8n5oEXB7Y8qrNkIGj3NjEdPuqalT7Q9u7RLbN0X
         0zmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=e6Rtsf4PevE9PvTtJeXKgCS6wQBFKBQ/vL+iN3PKGt8=;
        fh=GJbC9nYc/yzr7HJvBCAWk17aIYWlPhWcwty4Fd9fj/c=;
        b=cYnBVqR1aM1Lru+FH2AEfz7eTwMFjEHPMLY3buTpXMekgSU1tr5L/CzBUKNcARkN2p
         c/kXsbcKCMyPRYHRpnNdMH61tvb5ovm6r2mHMS5LhuhG/t349HRjxK/qwAiB2lM4tIOk
         GG3dc+S9lWdoGk2xKPPTnCTx8aSsX65f35JxbTqFkLLOB8v+MfwFNnNDSw69ouWlIhmR
         RStyry2Hapex1YgygIqtqRQW0DBGUUdceomcbnIrzxqkhwP/rwleflnyDrZXZU1oj93t
         ixCggz1lL3NA5RQ59XdijA3rz6BgQ79Y7zZaZ4AfvmG3CZQErzMMuhBsM/eHLUm3K6Dw
         gaQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789436782; x=1790041582; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e6Rtsf4PevE9PvTtJeXKgCS6wQBFKBQ/vL+iN3PKGt8=;
        b=P9DenRCpycIhvKBEnE5Blys7N7jAk35Mx8jMdYJwjom7r06FqhU0ALOgPMPsa83Tai
         VUEKtTP/52wbmH1hLCYSPRoxWh4D7c09xFqh5YXiiH/H/trCdg3KMcjkmzno/4iwS/uV
         ozpGYFT8efZRIt0zI11lkp4GXR1/JQnrmF9s29GVEGiHNi0Dy8WaiB5XicYsuZ3rdAIN
         STjOnpGzoUYrWi7Humky5guIwcEqhdVhTvDHD6TvM3algLqdGvmXvD+NXFKujd6YmFbZ
         yn8Pu9hcvd60GgBAeAzSLCf5N4oR+8e+CA365+VkrfFQ8hS4pTgfzDzPD1MEOoKE4hm3
         7p7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789436782; x=1790041582;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e6Rtsf4PevE9PvTtJeXKgCS6wQBFKBQ/vL+iN3PKGt8=;
        b=QHlx4gBZGufm5P2O2Bq0l6S5mdNY/b8Sx6hI//HAsSqoyr/AGxuLjwWQ70VkqD+iT0
         h4cb4lXZz7fI82KO1hyFg5OCTv1/zIRn7uNBqNs9cUq0joDcZg9g5knZXNuj2jbWgZxt
         jQ/fLXw7LLHYpo4El3HbWRSQLpJh20VlzfRRlYYdE8HWZDtSjbcJOtOI+jJOh2CxL3/g
         3s/ueLEvTK6tVp8H4oQf/DhOxHty/WA7D4LJySwSHloKEwYp4Hk65j/FZ5eerPv2F+8e
         4YXc9FkEJ0/Q8Tql1BOeQIbhPs8AVXOlhqYF9dWzi5Ag/bePk0uxyJqZ6X/WqjSlpSvN
         Le/Q==
X-Forwarded-Encrypted: i=1; AKwUvBxW+1njMhiYLc+kOKVD0fdLpfDaWPMCR8krM+b/vbcEsGcEldKgYMuHMMaEgEaoVh7gz1RwroA=@vger.kernel.org
X-Gm-Message-State: AFuF++mrnZ+x+ylJFiHbzV5tMlpwFu2T85g+SFx3RaxJrulP3E49hW0W
	TUwKLSlnBV3t2l9Tt+3DNqeaP89qjy5wL0Q6nfN8PG69RCOU5ORl/2p77qcRJx1eIMQxhEYAsl9
	YBZa44LmqlcTktVsEZ+j4Mv1f/2+Bc6U=
X-Gm-Gg: AYBFou1HnMZ0mXgi4lSP8UoqRfgpE/txledAKrM2cvMZDL3wS3rjqu5liJn9dHzQTQD
	AV4Y0Q74QBu3Rg9/lSnp/kpZc9Ptceyf6P/VTftXcs6BkMb7zyqSZ4q6+P1x78gmR6EbCYADrAu
	Dg5vGxr/SKR2zT+gGj/cf8hl1MoaTeNwqo4jCox4yviIBLgwlTdF9K7GcsDoeUpmCpZcvLxfyeD
	9FV3UY4+eEiXljrRLlhXqF/mW+TYaqnUjn8KnsgUrEta4en0JwhVgDWbo5Z0V4SlIbBXcCDIuSR
	FG9xjZoxpoyHMcel7xGxCbS73kC6/0e0GeQmxt16GXyUAsPj7gIzudYVbR7a55ERns6qXXqkZXt
	L0uvzOHeldSsZ0Q==
X-Received: by 2002:a05:620a:6086:b0:93a:1b82:4966 with SMTP id
 af79cd13be357-93a299fbf2amr786358885a.38.1789436781627; Mon, 14 Sep 2026
 18:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-ynl-robustness-v1-0-f255214c0f30@gmail.com>
 <20260910192314.209ecb01@kernel.org> <CAC4WM+zvK1zFuPfS5WnzuDR3b_DRX==x_S=Gg7LSLgZb9=33Ng@mail.gmail.com>
 <20260914161206.40a049ed@kernel.org>
In-Reply-To: <20260914161206.40a049ed@kernel.org>
From: tmbates12 <tmbates12@gmail.com>
Date: Mon, 14 Sep 2026 21:46:09 -0400
X-Gm-Features: AcwNN1UKqvRlDTRMq_Mwwijf6RGioo_kqiYxUoeC2Q2xdHrrH8YWaJ_FckKKh7Q
Message-ID: <CAC4WM+yDbV90Az8g1iTY=UepiDc7a4cWoo3tOEN62VYm55u5MQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] netlink: fix ynl spec tooling robustness bugs
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jiri Pirko <jiri@resnulli.us>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Sep 2026 16:12:06 -0700 Jakub Kicinski wrote:
> Do you mean kernel side code gen for OVS? I thought we have specs for
> most of OVS already, we just don't use them for kernel code gen (since
> it's a pretty stable code base).

Sorry, I was unclear on this, I have a feeling that I misread your
earlier point,
I didn't mean to sound like I was proposing any OVS work. Neither on the
the spec nor the kernel code gen. I do agree that 4/4 doesn't have any
necessity pinned to anything in-tree with that context in mind now.

I'll be sending out the repost for 1/1 shortly, and once I flesh out the rest of
the doc keys in the yaml.

I'd assume that starting the bridge spec out as an RFC would be appropriate
while we see how much work it'll take, but I'd just like to confirm beforehand.
