Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139F152F297
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914925; cv=none; b=RIEev6Te7BZs2flVS6es/qnXqZuWGLkuUQEhb7ETqgR36MnI3ccVoATnUVsMsTof68BbGHTkW6lJg0SILxPa9JCJ+0oJXMJgbbl/cV1b4E+eRduGlfPnKSY0Hwc2pk2lEombM8Zc8fOzZzP/VZXcLLgSceY3OAgrIcmojFSZWIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914925; c=relaxed/simple;
	bh=KZ7Ikw84/BJY3cQYIRg78sbHTdWFC0jbvTc+oRhuWZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdyeHXoGF3y0K+HNvc/JiVHJYoaigDzNSMnHqyJLZdYaVi4GEzR0fxKqpgBESrJA6xbldbelA+r47YtXhjIOjKViNfZFruy3GjxvfvEvP5mJwIPi/e324pvliJjOCeKc2tRO5kKy1kDM6QEFQsYYePV5fVcEvEOW8lvMZDBm8CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=OU6DO7O/; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="OU6DO7O/"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33c2520ad38so7538669eec.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 11:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791914922; x=1792519722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KZ7Ikw84/BJY3cQYIRg78sbHTdWFC0jbvTc+oRhuWZw=;
        b=OU6DO7O/n47QDkP/6ToBGE9uBdfSFxh1qTMQgIUPczVjSDP72WNsLKPTuX9LYtkikB
         p18y3yTeeAryzeZSji5vOM/KmQ/9TFPmlD8P4nG8VJkfNhRikQNkrVyfRvYFYS1O3ZW0
         qTBXkbv3VLzQwTKq8YHdGeKuMCronoX7eqx/GHVEkdtI+CLGTIX5EVCdxo7WLydY1h0d
         QSkmReGcz421PylsasTyX0ESpjzTch4P196B0f61KolydsobT3OZtTOD9cZg+l8PiDfn
         AND4uFS8X6nHYhBKenRPKx5FJiX6zrwSddead/FlKPPvYfsC7cxqeKDGg2NQ9EXDpX61
         NyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791914922; x=1792519722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KZ7Ikw84/BJY3cQYIRg78sbHTdWFC0jbvTc+oRhuWZw=;
        b=DIXJwvnrMnxSRcFGQIrE+Y6yW/0ETYcWJ2x1xXBbtXlR9mpTof5zx09DXmP7/9SEgL
         uS6dJRBtQs6xg93pmaAyXJWLdl35tOOqOYp++hXTvgSRrKNxWSIlBrZRcJTfJRLIxTtS
         hEKUurVFhdOLjh+emzb47DlAdJwkM0F4G4878HELHB1slDLyLQenilnM2t9lj8H3ahcH
         Kp/jLBg9K/rKI9C0abi0NgR1CZXjHUPxBXVTi1gFfe0E9BD5YBMwREeyQlftegNBDvgT
         eatw1l+ZMBMiZtHGTvjblgoJ3/6WseH0CHYp2L/UKy3AgDdmR2Kndd08+B2zNFtARQ/1
         ccSQ==
X-Forwarded-Encrypted: i=1; AKwUvBwoUtAw9BycsYiU2qFizY/vXhowuN7N8B/cGIu8+QjvaM1Je2B3pwZ9pjRwXSOj4w4cAYprr+E=@vger.kernel.org
X-Gm-Message-State: AFq9FYLj4Mw5c0izqWqrrDewvY86xGeFZIippJH3dHpbHSgEV3I3u8bO
	B4pp+NP4/Nl8vEvZ8WRvXtUX9mlnNK864JseQGdWzaW8zlLQ4IDj9dnRuGGsn3Q3M2VVwlrSPhf
	k8ks9Ok8rTUtQ
X-Gm-Gg: AYBFou3MwHFuma5XWPaMVGFllYjd238Wt97hkBD+78If2j5NHk3gpkUfOfd5wtvhdOm
	XV93C1l0PfcxJSQHJ+c+9+sVu/3Gtd/+8HCz+RJXhyZyc1qiOuJl4SwXJpIlBpIX4q5JQc5lGr3
	PwgzE0EBe+bqov8AcnZa+esVYYS+2nM1fyznR81WcwMD0LkBz7ArHJfobiWWOn82U8QFAA9mF56
	f5PuW5Rw0A2zaT17C3Sc/ootL2SfIYkXo7Tpja1/9F/F+Cq0cadtH/MuAA6DNn4Aiw1hV1Dv7eS
	GnYbmJMQOnAnpiEw7Ad6wOY93TPHMp5lvu4m4etdQT/wYkygpQ8QDWkvbpaMoaYSq6VJzuDkvJB
	59HlY+JNIRtS/w0iQFfXyCMDItHegZRcvj+M4/M4Q742d+uWN+w6B3BrLL3eeckwQXoCQ47+3hO
	OMIhGLTYl+VvDIPfERvYtUMcKPTRVbCCJaQ/BRIcQ5nFeQqiaVZIt9kZ5hZIEh/kpyHcuPAD+28
	pQPxhkA9JEa8kacWS+DhL7TZuybpMW36W1vNwjbXDbSDsHPkWod+0s/9w8qPK+C
X-Received: by 2002:a05:7300:c01b:20b0:354:b5d7:5a8f with SMTP id 5a478bee46e88-354b5e69defmr19403315eec.30.1791914921826;
        Tue, 13 Oct 2026 11:08:41 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([69.25.95.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2fd33sm43649502eec.28.2026.10.13.11.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 11:08:41 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: netdev-bot+sashiko@kernel.org
Cc: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v3 0/6] amt: relay tunnel lifetime, validation and request-path hardening
Date: Tue, 13 Oct 2026 18:08:36 +0000
Message-ID: <20261013180837.1282896-1-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012125943.558629-1-omar@blockcast.net>
References: <20261012125943.558629-1-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review. These comments are against the v3 series; v4 has
addressed the three issues introduced or exposed at those bisect points.

The Update path now takes tunnel->lock and checks READ_ONCE(tunnel->dead)
before either the IGMP or MLD report handler. Both tunnel freers set dead
before clearing groups, so an Update that acquires the lock after teardown
starts cannot add a group or arm its group_timer. An Update that acquires the
lock first is covered by the same lock ordering: teardown waits for the
handler before clearing the group list.

amt_dev_stop() no longer uses list_splice_init(). It marks all tunnels dead,
then removes one tunnel at a time with list_del_rcu() while holding amt->lock,
and performs cancel_delayed_work_sync(), group clearing, and kfree_rcu()
outside the lock. Every lockless reader therefore keeps the real list head as
its terminator, and the post-stop get_or_create() path also rejects creation
when !netif_running(amt->dev).

The Request-only lifetime issue is removed by v4's final patch. Requests are
stateless and do not allocate tunnel entries; tunnel state is created only
after a Membership Update authenticates. last_seen therefore describes a
valid Update again, and the global and per-source limits cannot be consumed
by unauthenticated Requests.

The pre-existing race involving a group_timer callback that is already
running while amt_clear_groups() calls cancel_delayed_work() remains outside
this series. It needs a separate lifetime fix for the callback and its gnode;
we will follow up on that independently rather than widen this stable fix
series.

pw-bot: cr
