Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793179675;
	b=JGEaUYYEtFFFXgdFRR6ZuTq63xs+76I9DoPq/6ei9cFBjpmIY2wP8tPrsb8884uUJ4p2
	 XFGylAhMg92iCMnVF+chifYmwSfZVwf7KTVgzb0pLfT0xT279KZH+HkOl8xLiueUtBYto
	 jfvkq0qV2b4+iC5/3sKt1H9VoJIM5Vt0zqSn/C75AezLW0GU+j7H3iJfzSJ2+BAOFIcX7
	 g5rhjX5kncjO3/fHclY2p/zvirVXj+j270DJzbeCUvlsvfwttb9CLMVJg/z2gjwbLssWa
	 mY5sjfyLTfv961J6ahZLOlUhHRAS1ic7ACpje//tGcpIwaxh7LuLUa9kw4KL4gwj9rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793179675;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bouMHOZSYgktXg+3k1sBjUJFbdMKRcN5fIavltsJbIQ=;
	b=u9cxD0zfzfjRwpka41YoyGk4wCzVX0CdCldUU64BNbPnTcpdYAZMjN5JWmENUgRa2ydQ
	 JRj28dEJemQaHAbYz9OFScMnGfvhdGNeYjARbr3R2qI58KepnMAr33We7XCKkpHeGjrqc
	 ANzZfaTfOR9wjQb+uohJuPOCUrlijOdKcr7MyfMyMI4+P4enivkx/QLSSOAUKcHO66vQb
	 anfiF/64DfKxH6L4QjKnSMEQajjBYmEKvmL2BLr9t3SHofHL6zI3T6Y9x8KiwN6PA/JD7
	 XcwUQ5fDDDrOXl9uSZqVBaOlt82fEi1rHeqjbx8f9NkmiBjubrBujNJJ4Yq+UmPDr/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smartx.com;
	spf=pass smtp.mailfrom=smartx.com;
	dkim=pass header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HkT6Z9AT;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403FF606A31C
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 403FF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HkT6Z9AT
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2182761eec.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 02:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20260707.gappssmtp.com; s=20260707; t=1793179673; x=1793784473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bouMHOZSYgktXg+3k1sBjUJFbdMKRcN5fIavltsJbIQ=;
        b=HkT6Z9ATlZ4/CzSh7Ji0MN57JsIxBOBy4cvDy8PvXc+Y5WfuXqh70XT8sTmkJ0uU2t
         +/HYANh/hInoJqDVpTGf5vuEzDq7zZw15gDdS3fe0uODgCNGxJe/zjOyObQU7FSW6we8
         QThXvKtD8gjh0BWI8pDo8dozq182RSn15XojUtDjC3jCzYvDdmC4obSD38cufXzqrsJm
         UUBsFVoI3MD5nQjLcmTH+lP45oTTRcJ8xtp/w5NbS69fBL0LYC3X+hulLvbhilqWg8QT
         iOJncHtiBKgJvZtPPXiYkwjHZvvl9e/SyvNDnpkzPuEKZkC+sIo0bAJVTfSoRno9zG5d
         BRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793179673; x=1793784473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bouMHOZSYgktXg+3k1sBjUJFbdMKRcN5fIavltsJbIQ=;
        b=yDO5vJeuKgDD4xFg7hdilKAvLrNngVRdLTLZ8KliYfSdJyuqFRVa+FlTZosBSma6r4
         rDwSNJtwb12omnWyF+6EDt0f2fn2P4ajmaTnaRHU+u3aj+gFWv+M6q5sN1f/aW8SKYR5
         KBORSTGPQ0qHu8uFdsODyq38zDr4iXTDlza7qPr1ia7eNpKAtE67Gx3tPC7khWmurOoj
         P2xmPziqeTm8rlWjHz5E4vEM52EFc9s3S6OdQswGjyQDfHSLUBX31/35TgZYjczgIxig
         8WS7uKLt80HZhyObbRasJJz3ZWfkqx9gWW0NAR1qcFRvR32Gj86u6cHzHrW4rUrtErxn
         RWlw==
X-Gm-Message-State: AFq9FYLtiR7XjM0l8MQalERRv1hGHsP+teRLcf2BgAawfMsdQ8B5S4bi
	4o/VjGsrRQYVIMdA1dTbj4bjJvVJZzLQCS+SeOYjD7CN0jaJMkWDMPNWD/fPwyO+JqICcjc5bqF
	9PQIWNjZNTm0YR+Z0kcPA/WF3d35wPZNkknEhYmenHPdxE05AVBv4eK9t/r0tjpoI9CcC7Sj+
X-Gm-Gg: AYBFou3Q3jMd7TWu5kezENe37tJVsxoQCWF/rTqp54UmHVv8+Bu5bYYzBPlT2M8Uuqj
	uwwUQJd4uPsaPY2kpQzrhGaIFQoss6OjooEKbfYD9A3/lRIZdIDBzASeeDpibvho9YZG6F5wKKI
	3fiLSZ8zbo7WGwtrycAfOPfmfmFdPfxuLCIxV112xFuBXptphMmQaGojF9cKO176ALv8Sv3cX6b
	2xNTOYZmDo5n3TfNEl2gbJPuhPnGGde0jcJBza+V6Eq+9nJOT85Y7Ckk+AfUXS5iK+FC9SzTI0v
	OYQv/zuQ7n/UqRLCMhBjB6PvaPVcFSzGMdhPX2RFHlt2x7bzmTotzR0322hp8uIKpup0Sjmrvz/
	euG2/RH/TBYX7nxKK1k6M7FH78wPYZKh1/SRYxRIdm8EnPHQYWCHlC5uMRATdOGAnDAmkQlmyEq
	L8w20GHA+0v+OG0qbQB+94XF9JBnOwFnvCPWVKqwfqZkG1I75OlNqDnHSsTHDa1CpjmwJ36RNXO
	+EWECDA2iFhhqlsREOsLW7/POGWZ2Op9lO0lyexMNXPp+JEXLJW59VmyGtNwLud0j2SQV4dUSHI
	2K+6RknPT81+7m376Ljuc5zBMgOAGnyamDrWrareiaBhov0phP2sASPSPpP47co=
X-Received: by 2002:a05:693c:88cc:10b0:366:6644:2839 with SMTP id 5a478bee46e88-36a202bdcbemr2987407eec.3.1793179672818;
        Wed, 28 Oct 2026 02:27:52 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a238dc80dsm5309669eec.9.2026.10.28.02.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 02:27:51 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>
Cc: Wang Zhan <wang.zhan@smartx.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	syzbot+c6c86a1c56b5131f2d97@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] net: fix self-deadlock when an upper disables a feature of its lower
Date: Wed, 28 Oct 2026 17:27:20 +0800
Message-ID: <20261028092720.1062867-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261027140121.1192299-1-eva.kurchatova@virtuozzo.com>
References: <20261027140121.1192299-1-eva.kurchatova@virtuozzo.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On Tue, 27 Oct 2026 16:00:49 +0200, Eva Kurchatova wrote:
> There is no way to tell whether the current task owns the lower instance
> lock. Try to take it, and otherwise leave the job to netdev_work, which
> disables the features the uppers lack under the lower's instance lock.

We may not need to tell whether the current task owns the lower instance
lock. Instead, we can check whether the device is already in the current
notification chain. netdev_features_change() is always called with RTNL
held, so we can track it with a global feature-change stack, like this:

  /* RTNL serialized */
  static stack netdev_feature_change_stack;

  netdev_features_change(dev):
          push(netdev_feature_change_stack, dev)
          call_netdevice_notifiers(NETDEV_FEAT_CHANGE, dev)
          pop(netdev_feature_change_stack)

  netdev_sync_lower_features(upper, lower, ...):
          take_ops_lock = !in_stack(netdev_feature_change_stack, lower)

          if (take_ops_lock)
                  netdev_lock_ops(lower)

          ...

          if (take_ops_lock)
                  netdev_unlock_ops(lower)

> In the deadlock case above, the lock holder is the context that sent
> NETDEV_FEAT_CHANGE, so steal the pending work at the end of
> netdev_features_change() and run it inline, like netif_rx_mode_sync()
> does for rx_mode.

The "otherwise" path takes only the instance lock for ops-locked devices:

  netdev_work_proc()
    netdev_lock_ops_compat(dev)

but then reaches:

  netif_sync_upper_disables()
    __netdev_update_features()
      ASSERT_RTNL()

ndo_*_features callbacks also require RTNL, so the deferred path cannot
run feature synchronization.
