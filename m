Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989CE32A3DA
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 03:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789270358; cv=none; b=jCt00HfBImrUQAbxdOK9Eg+vr885hpy+DhkZYC5UHXreBHbmBP8bZSKlBc6/ORn5jYa/n+sRvc2fLriUKE2cWsurkszjfQuC1Bz8OPrkxUnPrrcHXxijmlm+FAOZ0UbdYBJrj5MO4OSxO/+4XkVnI9ZVYbwDsbZeZ2EFq49nrn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789270358; c=relaxed/simple;
	bh=qynwl3yegS3zN7wkeohcoAEZv4LlKGQdHuntDJ7koXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r99he832gbXlN3L/lSVRn9oYk6xdNHxf2BJ20W/ntkESHiACLkMNo+9HaS2f+B67IvfgYmj98k01lseQWsyMveJd1LKG4sNNBhqGzZ7ncP4OeghrA4upc1rtqg+VjEIVRt+q7Q8i6VeUykj/Mk+pvM2zBYdSWZLjfBQq6U30y4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+xqe64m; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+xqe64m"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a49bc59559so5175541fa.2
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 20:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789270354; x=1789875154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xjaL8mti/vahJlLkdMnZQO8Ei/dHHViRxDz/+EAVwR4=;
        b=K+xqe64mRgpbpxbwP50a8Gjn9ttToXXtZlpjd0dHUzX4hfIf/lDYCkhhnDVPXq+KFz
         7o2+pmeKCd6hsbS6GHLrWGhySFNxYgHXhSnTV9gCb9VuOx8dJRt3kjBzxZ6hoZrhPZMB
         OYNsqyK6F0BuX9KM4MXBJwwWCW1/i30zypBbJ4QHrvg8yhrrEGZPF7LrhFMuAzAr0sAK
         1H/WPP6HZYHQa2lchsZB/laJsrthtdbJT7hu6AbhkNiLbHWFsk8e2D9vAh3x2Nv3qsKR
         zkS5AnByw75wLEg4xhoZ6b3VFRowNutb6Ws6/gTFXgLvoS8TjyXskItoEAi5XlCRhVnm
         bUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789270354; x=1789875154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xjaL8mti/vahJlLkdMnZQO8Ei/dHHViRxDz/+EAVwR4=;
        b=WHopy29v0YshbHz1iMEWW6SPtI3IXW5QaegGmRd+ZguTLmN+3s+87BsAJpTLVLFxYk
         cm/Hg1pq8m8aLXj9+d0/UyW2YfKwIRJoH6KohUg88140ND71fWeC0sLh76xZkHBtZluo
         CyduViVFZ+zhQVndz18juQaSxlP1JC5pbp+Q7v+PddueHuritPO44lAo1OyawuFK+44/
         w0VubUbwl8GfTmWBGa89Sa5dxOPJJV+LjUjlTvf6u55ehzAZlKnmHEevostaSTez9ZwU
         T6GV02j03W0bURcweJVfEiGjOQE8xP5o6w/wC5ZvBMScNdvljtn84zvZ1TwOzVq7xVT2
         uuqg==
X-Gm-Message-State: AFuF++ns/wi312Yzv+xwAtKZC51uKLP/HdY5CRizXx9Nm08KfGYj7f19
	X9gm7uXcZKZsVuiSiCHL61dwWw1IIvD/mrQfUfadzGcUz9vlxj7iMiJY
X-Gm-Gg: AYBFou082gevUed5PeQTi4NvLEyphFJRlBe9q/F6ga5V3WLVgpWgEFW0tNa4Ci7jatA
	Yqij8R5GEoKglopVEggyBw8OClaLRsFR7wxLhS3MBD7aBbeknYU7T+TeLNU10vmILk/QL7v+/up
	bSOn+xj2zat12Y4nUZXHlSqfmkULeNGgxxqNjMMuSbVhOWAxj/23l2zwgGsLWol9tmcTQ1/5+F0
	kbKAds2rbbi7AyMcNX1LoUruk0EXEtDwyktZTSN5nPGnlC0LjvG2AAP+1PiMDxrcn2d63a7oOHj
	52hg21rDZjs2YCGJfrrsLGTQf16giEYwp2cHT17FfaZsssQbE+QYnMCrYojQhz3r2M9wzOcN5Ir
	JiKSWxH82oT+3oO7Vv9Wzo1Fck3xUg+aKZWbcbqQkbt9MMVesEeuJ6BTpQJ+PuSWFAiUQQHsLLQ
	qWr39cHQkHUuJ2/oxGfZ/Jo0I0GEGoNsUJjp0599o/BpUn4VYjmaTPzrndslaj5sIqcWjUs/KKl
	ep1B1mwsdcoAdSiCMcbJ2ZUBDG+llNv6KtDZ2bfEMP0
X-Received: by 2002:a05:651c:144c:b0:3a5:ba1e:8b05 with SMTP id 38308e7fff4ca-3a5ba1e8dfamr2827451fa.1.1789270354310;
        Sat, 12 Sep 2026 20:32:34 -0700 (PDT)
Received: from dau-home-pc.. ([95.139.134.117])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5a33a1cd1sm17024041fa.42.2026.09.12.20.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 20:32:33 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 03/11] selftests: net: add a test for the tunnel RX drop reasons
Date: Sun, 13 Sep 2026 06:31:51 +0300
Message-ID: <20260913033213.873609-1-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902184549.63f37d04@kernel.org>
References: <20260831215137.549324-1-littlesmilingcloud@gmail.com> <20260831215137.549324-4-littlesmilingcloud@gmail.com> <20260902184549.63f37d04@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2 Sep 2026 18:45:49 -0700 Jakub Kicinski wrote:
> Completely unclear to me what the value of the tests you're adding is.
> Please look judiciously at the generated code

Dropped all three selftest patches in v2.

What they did: bring up two namespaces joined by veth, build a tunnel
pair that disagrees in one specific way, send traffic and read the
reason back from the skb:kfree_skb tracepoint.  It is how I check that
each path I convert reports what its commit message claims, and it is
what caught six paths in an earlier revision of this series that still
freed the skb with SKB_NOT_DROPPED_YET.  That value is in writing the
series, though, and does not by itself justify 346 lines in
selftests/net.

If such a test is wanted at all, I would rather come back to it
separately, once the conversion has landed, and in a smaller form:

 - perf record -e skb:kfree_skb and perf script, the way
   openvswitch.sh already does it, instead of driving a trace instance
   by hand;
 - only the cases that are not evident from reading the code: a peer
   that reboots and restarts its sequence number, two ends configured
   with different options, plus a control case where nothing is
   dropped;
 - every case tied to the function the drop has to come from, so that
   the same reason reported by unrelated code cannot make it pass.

Is that worth having, or do you consider drop reason coverage out of
scope for selftests/net?
