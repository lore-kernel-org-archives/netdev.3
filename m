Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091F43CB56A
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795994; cv=pass; b=BGRW+4dkyIY/NSpl6GNKfFo9Zh+EvzcEM8BEp8r616csXdnJXLpRDByhL0ZKbUjgVcrhNYtg+2zS15wL+FauA5xkCUAOVDCwaXcDIWao/l3xTeOZ1UrOvQVtGVg740EDPVYP4jgY0XzzDfJSItL3kBZivf93K3i5GUzmXe7jTs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795994; c=relaxed/simple;
	bh=DateFYEM8RUPCqkCJj0bcYedClzNO/Bshld4N7qd/Wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+yh8ujfTqosiPiZd+23ppYEgrrPO2493yqkPOe3OKQni+TMjZsR9PbZr/jtO6NNHaDMuk/z2cZUR5GAmkzc0jBqm2v5e0Lwdp+ACkLxnqzcvrD6uiou9fNEzT26FmXL8NfOIAR2ZkR5sXZmfiQhFkAVGZlhuIvuz6gH5YcTHGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SJ3Sv9uN; arc=pass smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SJ3Sv9uN"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-532db7db0c6so52819651cf.2
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 12:19:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790795992; cv=none;
        d=google.com; s=arc-20260327;
        b=MNCzI7Fatu9VmaQBY+Yw4r6qWvPHHThdCNEqR0kjk3GSC51vDK3ONANHuUed19I1vx
         ZWWfjGqVgu1RuyIdEsM7P6qYo37MhlhjtuB4jS7vCndfknBdUhIwkbtQ+3sEkH6Rb5DD
         9UG1+JwVX9bpbeRIqbd9bg4RQIWuKYDJR+cS1EoNAVeV81iSgiuMKCfRfOvSAftRYtuS
         16wUw/CS/1dzO9GUsyL/+0h4hcsiNqgFjd22RAN8ULS5Eoda1J9XgWcAWjIiOwzPcI/4
         O9rwG5DDbA1NjplvEvWVhpKr1/7VnCBStWvMMP/sodOuVHczN5RzI1qf3EnfA1OtmKM3
         dSSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DateFYEM8RUPCqkCJj0bcYedClzNO/Bshld4N7qd/Wg=;
        fh=98BjfljXRdOeYfzBf8GQw3WNrwOIK+ahJkyTbrTxxx4=;
        b=sXLfmAQlvB8OLuZHnRZrkDOzoiNetzwMhoX6CLngfP7PBfuRnc8M9HM3tW16VYuPeg
         EXOhbZ7rjEx52YURMWw10VNhv5hEwHXCJYO1HeNcm1r6z31do07gLNukm89lJaNGdT3M
         BuARlr6fHU6IgI7B2N5MYwF2zPcbWV4S/9oL0cLyES8SXmD9dI4l7KiZB0lKoLlLNBSN
         m8pES+bcGzSGDpDXpnxBfekJYqkPxGczWjE8Ghqa3VzV1r2XW2P4mdnKnPTbKHgbzHEE
         nGJOTZhkLa3TEHInza25qHhEfu77tinImguZCe5i4bWD9A5b8r+3y+uOBTAPShCR62vk
         tZGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790795992; x=1791400792; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DateFYEM8RUPCqkCJj0bcYedClzNO/Bshld4N7qd/Wg=;
        b=SJ3Sv9uNhnpIWRPLoH7HhGJYsfwfZyhe7O2vcwCPdOJ066HUByEwRFAbMsmDJbklV6
         l11RIdRoDHb6g9zxLwpRvP/ZiUTLsMhREnGcTKN8oElK0/sI2NyApbXWMQ+E8Fno6U1N
         6umLoYcNew4OzosHScwcdzxSRjA2HV/ECca16NudHWFZmGbg86xCbJiO2XS96Oc1aWip
         AvaXWSuY7kwCzzap0eStlT9Pnqb3CdleVCeE6JiIWmdiDu1oR4Vw6U4lXqhVAUtkawaa
         L0lRML+YxexT3M7pN8jQVyWD4r66CHEcBT5MSP5tGPXeLK3AORlrz6kMWvUH0wRtayz1
         iKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790795992; x=1791400792;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DateFYEM8RUPCqkCJj0bcYedClzNO/Bshld4N7qd/Wg=;
        b=aE7ZqYlprL1h2U6gKAx1NP22Q/6tRZ/ZDw69bV+ulGbe8cJjm0vHlqfYaWItUy35el
         dfaOby8dhDps9Apu0F10+MzZqzwYXgzdtnDKXYfL8hVB3JPOclDkFojvUyO0qypX1I6m
         t7uSZY3YMhyagQqCQgGwesYmVB2UW/Zs1otwYjNLXiVavA4Aigq/b0ABatiqKpVWX5eP
         vp1dyq7PItyZCoHsIgP8TbbUX3TBEJMBAXWhDxggOeWuhBoZlCYX6q3oAE0jDLhHNMe0
         m+ppix84CMN/YSpxWUKNX2cwKJtbcM36j9l977ct+bwNGYjGrBje3ZxEh9jlQPcmtAej
         YizQ==
X-Forwarded-Encrypted: i=1; AKwUvByYW6BKXzgJgPdxe4gFkdQiv50k2DyR0sbGW7VglP8mME9d52pHc+MSQ+DFKp2FmX42jetRuHU=@vger.kernel.org
X-Gm-Message-State: AFuF++mskqseyGjCn+IT15F4e9tjCyh8l7KTDjOPtpAxL5kT6tNZyFKY
	rxroW8qPHqdvsdC/0Cost/7b6NheYfY0R5gfEyPs39BlFshrKnRzwlw5YisuXsoyWhBn0kZcWAb
	0vLd539qvOeNq0yjPWwNXBbQs+GQ9zeBRu0Z5nB9o
X-Gm-Gg: AYBFou30wrWP1/k2gp/9e5cO1msTHwfAEgfxzzgs9EZfyJ3hfCvyCSjF+9ruqjVeUYP
	tgzWxPNyIXub27N80jZRf0olYEahA69/zT1xEhDNFbAYvbDmSg0k8+OZenzSfqiuHRdKP4KXCce
	FDZsXDkRMhU8xvqkLGVrhlPMftyyi/BPtjaF5RK1vvrrnHeaL4tMAbcr55uK1O84zB7BSWKUWO4
	+V7XEnF589/nm3RX0/WQWTQ2VDyb3ReVD+NkYJ7nN19+Ubfw5rlyRJqMjyL2wl6oUP23x49UObX
	KWsqrjeK41VkTrlwtvuk1ez9/FrI9MIKHse+9C0U1lmk25yHf3zYC0ED3V4A8GUonutjubNxzqz
	4z7BsUwRxUgO/gRat4yXA/sotEeB8cBRXHlG3eQqPGydLxY983jxpPbUaftwF/z9230Rz
X-Received: by 2002:ac8:588e:0:b0:533:370c:75fe with SMTP id
 d75a77b69052e-53374be3ee5mr46752231cf.34.1790795990138; Wed, 30 Sep 2026
 12:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930181106.271547-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260930181106.271547-1-nicoyip.dev@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 30 Sep 2026 21:19:38 +0200
X-Gm-Features: AclHuK92DSJl986_dvvpkYAOimgT3MaQg3DtlnvZZM1zBmoeCA_G_FvqALGK5WQ
Message-ID: <CANn89iLvY+GUVDQi0HLf6GSes9trxDWq_JRTiSBPTjjLib9pog@mail.gmail.com>
Subject: Re: [PATCH net v2] net-sysfs: release queue trackers before allowing reuse
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 8:11=E2=80=AFPM Chengfeng Ye <nicoyip.dev@gmail.com=
> wrote:
>
> An interrupted sysfs_rtnl_lock() can drop the last kobject reference to a
> removed TX queue without holding RTNL. netdev_queue_release() clears the
> kobject before releasing queue->dev_tracker, allowing the queue to be
> re-added while the old release still needs the shared tracker slot:
>
>
> RX queues have the same ordering. Their removal and re-addition are
> normally serialized by RTNL, but CONFIG_DEBUG_KOBJECT_RELEASE can defer t=
he
> release callback to workqueue context and expose the same reuse window.
>
> Release each tracker before clearing its kobject. Pair full memory barrie=
rs
> on the release and add sides so that an add which observes
> state_initialized clear cannot install a new tracker before the old relea=
se
> has finished accessing the shared tracker slot. Keep the numeric device
> reference until after the reset so that the queue storage remains alive
> throughout the callback's accesses.
>
> Fixes: b0b6fcfa6ad8 ("net-sysfs: remove rtnl_trylock from queue attribute=
s")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
