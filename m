Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E13490C07
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789237356; cv=none; b=G7FJd3qiP2WtV2c8KUbyRdNqxoaeCDeEOYv9E2r/DBXKNSmYC6X20BailJtgGGZ7qdTr67S5ByOJUC4QIITnmRAQIoMOFDAneP08sIGgH+i5Wv5eIV4GX4q+jDscn9ltdz2r7vtUPEVu6FzYCUgGQc3OYZV1fzrhjzunccy75PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789237356; c=relaxed/simple;
	bh=3Z4yz3FZGni8K4IueGtIHNjXsDdukNVZ0fkuclGutFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sP471BcpCTZ0PzYs2XTxhLTngVB4cqYzZrIPSjik6gXqXOLxYDq64TNPBYA+eusAN/U4QWgIdzx1uhERL+LSmWDHQ0X7XvepHC7qJCSKunxjZzWyAmZPVTAQG3fzbd63/gnO996DkeYQecw+TZVYPs1XA/JlNxovvSjFCuJFSsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4hGXfvD; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4hGXfvD"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a990so562932a91.3
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 11:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789237354; x=1789842154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QsDGJSn8W3IPc9HLbr26w5Jqm8wz7PGr9NNVjjKLx7w=;
        b=I4hGXfvDoUs0WCt52O2x5rZZ4pCjccsnWgdpZbVRWsr1XZbGGQCO9VE8M3zgKp+HRI
         ATRw+pMi1540onNLWSaWZgXdRspz0v1uW12Nu0N7CZUFRGERN5iRGkPrWAyZo4XrAPno
         4Fu8nhsFHeAbpcJheD9bHm9AgSzjFfOhSLFyveQTrIv0fMpKpLXwlL9ywZFNntEzavrm
         ozjNHoDf6vOVb0AXrl6f2pXVJIh9S7E1zJYLAYZeGISEh5y7wDp3RABNYuQvNYYJwyJy
         10O+qGWJr5FgoeN1rIxRBL/tXL7BPAxVWxkvvi68zOfU0HC9iaXKYjnwbHrMjgJ5Iji8
         XIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789237354; x=1789842154;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QsDGJSn8W3IPc9HLbr26w5Jqm8wz7PGr9NNVjjKLx7w=;
        b=sdPu/uGTwToHJFkhnZjKgdhEog20FQtSrlnnTmP4besA5WVqONGOCC/bqYSCSOgYHP
         u9GoO+53jVxMucoGMr+IyZiocX0rbAao7bAUwG2z8zVWuFbEOcXIKo/wqfxVK19Ho5Vj
         MNSVTTDGBsX1/JWSvEc/PogE+YGl7Zjmn2J6VMhPX5bGjzs3s7zURCNd9DSUOg94yg60
         goY7qFBvZ820IEvq5VsTWz78AIwwwF8OXmoEzrVgA+6zzTMF/j2lX8fBFa4dfXEV24ly
         6EHYiPBCgyZGd+4xFVySx4YXpWyt+/zNn+SdG4I0tgph1f5S+tKZY6IhdoYcZ0Hs6dRi
         Fobg==
X-Forwarded-Encrypted: i=1; AKwUvBzHMvf8HnLyGyjyPa8gtw++N62PHSi47QNAmJlJKc2k0GVRI8YQBNpE8XyYrd8P4IN+VJcK9k4=@vger.kernel.org
X-Gm-Message-State: AFuF++kFeUDLNFS+88phuY5dS9IptMm6HupecUVpJtQgKeHTOABTPU/5
	Ez0InaINnwrJ4K3I56Oay16y4WU+8Y6GxgFZbKNAmea8d3v+wB0N5n/eDsAl+eko
X-Gm-Gg: AYBFou14NaxtmUYNh0oKHivqgNHfVEY9Crsfe2KGaDYwZnMqt+eRXBVNo5dtaCNY0yW
	zq7sXy58pUEsK/k40Od2C2/a/+yNOYt12q+PPq0CAPDlx9sU87pNAITZcI7ZmeofIiyBIChkWjn
	+5DLKT7ZMQNf4Gr15fDU9OoVRG/TYByU/aqkV5KzD8oK6OQYKZ/8wickCPh2aVRDBVYZ8hQO4yO
	xJ1k5cjktv/rjBpvqHyHUEQQdMno8nUS8x+zCuOkZ8kPePfgGS7Hh3BZqLu3827BDLh9yb2ZhMe
	OiE89akmpiaaPwVaNCHsul8EsNjfRRhrQsZ9vrRzaA2yL5cP19ufFwb0c6jr9ZaKrR4NXX/yCOx
	6DMqsyF955/v5MwkPwZNZOhaqHJHHFukm/UqW0BXigusHBw5ItWUMtfJvZiBMJAOHA9vPOnxI5r
	6RIkzwPyLBbbbw+rKZYE5dRCyvXtvVwCpO1obB/Rt4z6dnDJ+eov26KMbciuzYrHn9ZPHbGA==
X-Received: by 2002:a17:90b:582f:b0:396:d28e:bd8 with SMTP id 98e67ed59e1d1-39dbbea2aa4mr7297063a91.3.1789237354308;
        Sat, 12 Sep 2026 11:22:34 -0700 (PDT)
Received: from gmail.com ([2a03:2880:7ff:2::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d987e755fsm11655779a91.0.2026.09.12.11.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 11:22:33 -0700 (PDT)
Date: Sat, 12 Sep 2026 11:21:42 -0700
From: Narcisa Vasile <narcisav.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Narcisa Vasile <narcisav.kernel@gmail.com>, netdev@vger.kernel.org,
	daniel.zahka@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, shuah@kernel.org,
	horms@kernel.org, willemb@google.com, petrm@nvidia.com,
	anubhavsinggh@google.com, richardbgobert@gmail.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] selftests: drv-net: add BIG TCP test cases
Message-ID: <aqWYNpcPRjTAoDok@gmail.com>
References: <20260912050327.20616-1-narcisav.kernel@gmail.com>
 <20260912093226.529ff414@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912093226.529ff414@kernel.org>

On Sat, Sep 12, 2026 at 09:32:26AM -0700, Jakub Kicinski wrote:
> On Fri, 11 Sep 2026 22:03:27 -0700 Narcisa Vasile wrote:
> > Add four new test cases that validate coalescing
> > under increased size limits (BIG TCP):
> > 
> > big_tcp_data_same
> >   - validates that equal-sized segments coalesce past
> >    the legacy IP_MAXPACKET limit.
> > big_tcp_data_lrg_sml
> >   - validates that a smaller final segment coalesces into the
> >     previous chain of large-sized segments while crossing the
> >     IP_MAXPACKET limit.
> > big_tcp_tcp_seq
> >   - validates that a packet with a wrong sequence number doesn't
> >     coalesce. The test uses a sequence number for which the low 16 bits
> >     correspond to the correct sequence number to validate against
> >     truncation bugs, since total aggregate length crosses over the
> >     legacy size limit for BIG TCP.
> > big_tcp_large_max
> >   - validates that coalescing stops at the configured BIG TCP limit.
>  
> Still failing:
> 
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-drv-dbg/results/819882/3-gro-sw-py/stdout
> 
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-drv-dbg/results/819882/3-gro-sw-py-retry/stdout
> 
> Grep gro_lib.py for KSFT_MACHINE_SLOW

Are you suggesting to just skip the big tcp test cases on slow machines?
That's the current behavior for the large_* existing tests.

> Then the 15x increase is probably unnecessary/too high as well, since
> we GRO 64k 128k shouldn't need more than 2x ?

If I skip them in slow envs, then yes, 2x should be enough.
Those pre-existing up-to-64K large tests don't pass either in the run
above. They're skipped, so we don't actually know the proper
timeout value for them in this test envirnoment. From the test run above:

# #           Received {40560 [!=65495]24935 [!=599]599 [!=0]}, Total 3 packets.
# #           /srv/vmksft/testing/wt-18/tools/testing/selftests/net/lib/gro: incorrect number of packets
# # Ignoring ipv4/large_max failure due to slow environment

Instead of skipping them, I was thinking to change the approach and
send packets continuously, enough for more than just one aggregate.
The the test would verify that at least one aggregate passed the 64K boundary.
I'd also keep the increased timeout. What do you think?
