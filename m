Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAA935E955;
	Mon,  1 Jun 2026 21:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780349055; cv=none; b=P5ZZXG9KXsZQYYHsCnHFuOlqOF25/gTSK4YioItZ/Wc8XGiEExvLr7wuTdsARKLxzf+LgXoCFnN1i1UMzO86arBydKOUfNtXEay5MRDFcJsXxanlx7ICYIRxfoIeHA3o9D0yq47IDrHiMLV7jjN9K/fyJp7pjUMDvEZrSdyoW2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780349055; c=relaxed/simple;
	bh=1vM3W+JQ09XkeNOtgmnMTDIPanSYJZWdOHp1PCMvpgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oYbr8vr+Z4plHPzlCRxtMl72mOiIsPpEzbfaYpz+3XIYA9BhSAnm/lxLBH1k5WEhDNyHT2LU1Q+Gl/4dIA8A6Ofj/Z00UJ56YimB/S46ILUhgYT7dgJUM88ZfMYkcEo8++KhoLp7JW8nwQSs5D3eagTjpfW38BTEWFTljdEkCW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=jOZeQpWF; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosa.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b="jOZeQpWF"
Received: from mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:31e:0:640:f144:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id 758FDC0DAB;
	Tue, 02 Jun 2026 00:23:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (smtp) with ESMTPSA id uNmUIGBfGOs0-rmoKQihi;
	Tue, 02 Jun 2026 00:23:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosa.ru; s=mail;
	t=1780349037; bh=kXNNOl38MMiuatEcNKAN6na8XaHmuLGliBnJEOAOofw=;
	h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=jOZeQpWFjC6IX7c6sdXOEmRUyJVVOHD5Ruc9w5php+RDg0j1T775FMLwcGBGbdnvX
	 d3+9OrIiTboQ7iLZkGVRm9OiEPawtGtgJDJRMtck6qwL+db6RHdpU2tAK/Fgbv/cif
	 +4ckKEeRmcqF5KQTC66pm8QsVLHjBZudrYfZWQ8M=
Authentication-Results: mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net; dkim=pass header.i=@rosa.ru
From: Mikhail Lobanov <m.lobanov@rosa.ru>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	gnault@redhat.com,
	liuxiasong@huawei.com,
	lvc-project@linuxtesting.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8] l2tp: fix double dst_release() on sk_dst_cache race
Date: Tue,  2 Jun 2026 00:23:55 +0300
Message-Id: <20260601212355.17891-1-m.lobanov@rosa.ru>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251216083541.70fb3b54@kernel.org>
References: <20251215145537.5085-1-m.lobanov@rosa.ru> <20251216083541.70fb3b54@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 16 Dec 2025 08:35:41 -0800 Jakub Kicinski wrote:
> This seems to be causing a leak:
>
> unreferenced object 0xffff888017774e40 (size 64):
>   comm "ip", pid 3486, jiffies 4298584595
> [...]
>     crypto_rfc4106_init_tfm+0x41/0x190
> [...]
>     esp_init_aead.constprop.0+0xe4/0x340
>     esp_init_state+0x83/0x4c0
>     __xfrm_init_state+0x6f2/0x13d0
>     xfrm_state_construct+0x1455/0x2480 [xfrm_user]
>     xfrm_add_sa+0x137/0x3c0 [xfrm_user]
>     xfrm_user_rcv_msg+0x502/0x920 [xfrm_user]

Thanks for running this. I don't believe this patch is the source of
the leak.

The leaked object is the AEAD transform of an IPsec ESP SA. It is
allocated by the XFRM control plane when userspace adds an SA
("ip xfrm state add", comm "ip"): xfrm_add_sa() -> __xfrm_init_state()
-> esp_init_state() -> esp_init_aead() -> crypto_alloc_aead(). Its
lifetime is bound to the xfrm_state: esp_init_state() stores the aead in
x->data, and it is released by the state destructor esp_destroy() ->
crypto_free_aead() (.destructor = esp_destroy in net/ipv{4,6}/esp{4,6}.c).

This patch only rewrites the L2TP data-plane transmit path
(l2tp_xmit_queue() and the new l2tp_xmit_ipv4()/l2tp_xmit_ipv6()
helpers). That path never calls xfrm_add_sa() / esp_init_state() /
esp_init_aead() (so it does not allocate this tfm), never calls
esp_destroy() / crypto_free_aead() (so it does not free it), and does
not touch xfrm_state lifetime, so it cannot change the refcounting of
the reported object. The leaking call chain executes no L2TP code.

I could not reproduce the leak under kmemleak, with or without this
patch. Li Xiasong reported the same in this thread: the patch fixes the
race, and the leak does not reproduce for him either.

Could you share the exact test/steps that produced the report? It looks
like one of the IPsec/xfrm selftests rather than anything L2TP, and I'm
happy to chase that pre-existing path down separately.

I'll send v9 (rebased on net-next, fix unchanged) shortly.

Thanks,
Mikhail
