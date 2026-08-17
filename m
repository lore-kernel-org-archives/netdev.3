Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0323BFACE
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 23:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787010702; cv=none; b=duud7EgNCS+c+F2OJXD0OjjDFAX2rMMqt7HUAV29QaeCZ6HmIF+N3CW4p9DSgpgrSnhXDbhJiBaE28CpxnwMygX7DQbtyjq5zpmcUBHv0yJGh3s7jPucBpDtjcJ6ge0DDVoMdxuwIMDLYRwsaHq7ROWFNcQHeIZ4HB4znzhH+xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787010702; c=relaxed/simple;
	bh=qZ6RCaMJK8csJZPbHhEovDRyqngCzPZqnQqSBGAW1rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Py9jcy19o2wShDocCe3sBzUShn/RQNTjbNDvh0R4KG1ICoGSGPThN11a4gPsfy4H47/z9BvpY+yMR+yLQvwyYI7Rh3onaOVMXqAUeiDs0vznRmldX2X8CjdGyhNyOM66AJN83xRy12PY55AKx+FbbYuS9Kvp0rlFyhBkmiEJrEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4TsBKtJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4TsBKtJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341071F000E9;
	Mon, 17 Aug 2026 23:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787010701;
	bh=jIkD8MSTBB1CDAAW1Jzav/ewcCPal1U6dKELvV5/i88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J4TsBKtJpMLXDZ7tGt3paIie90dcD1qX2jqH0WsAscgvfc5H1/q2FlzVhOQczhdT2
	 TFCp08/KqxGM87WawhiYMmkVmBuec+by8CsXhGm1RZP/4lUsu3Tv92OljIooELmwah
	 4TX1oTj+ztQPdcJfTceq9SR37FlVgrKHAxuN4Bmj8N3UnGND92bj5bvxiaF4LPmMJh
	 IVC44vM+9Rm1iRJacEev+CxLmtdRQhqOEo1LuNRF4nFrz76eCKxQpwv0XHPJWACQKc
	 nMf2aCj4zwYUk9LI0/H2a2hPuHZtn3q2VbunYQ+9DibcFXUpMfi0mi4jZ36D4Sdg6Y
	 f2e/I6CZ3v82w==
From: Jakub Kicinski <kuba@kernel.org>
To: dmantipov@yandex.ru
Cc: Jakub Kicinski <kuba@kernel.org>,
	bharat@chelsio.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH] cxgb4: use kstrtou16_from_user() in tp_la_write()
Date: Mon, 17 Aug 2026 16:51:40 -0700
Message-ID: <20260817235140.3752193-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814064127.1957130-1-dmantipov@yandex.ru>
References: <20260814064127.1957130-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
cxgb4: use kstrtou16_from_user() in tp_la_write()

This replaces the open-coded copy_from_user() plus kstrtoul() parsing in
tp_la_write() with kstrtou16_from_user(), storing the parsed value in a u16
and dropping the explicit val > 0xffff check.

> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
> index f521737d12756..5c6c274188913 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
> @@ -664,20 +664,13 @@ static ssize_t tp_la_write(struct file *file, const char __user *buf,
>  			   size_t count, loff_t *pos)
>  {
>  	int err;
> -	char s[32];
> -	unsigned long val;
> -	size_t size = min(sizeof(s) - 1, count);
> +	u16 val;
>  	struct adapter *adap = file_inode(file)->i_private;
>  
> -	if (copy_from_user(s, buf, size))
> -		return -EFAULT;
> -	s[size] = '\0';
> -	err = kstrtoul(s, 0, &val);
> +	err = kstrtou16_from_user(buf, count, 0, &val);
>  	if (err)
>  		return err;
> -	if (val > 0xffff)
> -		return -EINVAL;
> -	adap->params.tp.la_mask = val << 16;
> +	adap->params.tp.la_mask = (unsigned int)val << 16;

[Severity: Low]
Does this change the accepted input length and the returned errno for
tp_la_write()?

The helper instantiated for u16 in lib/kstrtox.c sizes its buffer from the
target type:

#define kstrto_from_user(f, g, type)					\
int f(const char __user *s, size_t count, unsigned int base, type *res)	\
{									\
	/* sign, base 2 representation, newline, terminator */		\
	char buf[1 + sizeof(type) * 8 + 1 + 1];				\
									\
	count = min(count, sizeof(buf) - 1);				\
	if (copy_from_user(buf, s, count))				\
		return -EFAULT;						\
	buf[count] = '\0';						\
	return g(buf, base, res);					\
}									\
...
kstrto_from_user(kstrtou16_from_user,	kstrtou16,	u16);

so buf is 19 bytes and the input is clamped to 18 bytes, where the previous
code used char s[32] and accepted up to 31 characters.

For a write longer than 18 bytes, such as a zero-padded
"0x0000000000000000ffff", the clamp keeps only the 18-byte prefix, a
different value is programmed into TP_DBG_LA_CONFIG_A by
t4_set_reg_field(), and tp_la_write() still returns the full count, so the
write looks successful.  Any invalid characters past byte 18 are also never
seen by the parser.  Should the handler reject count larger than what the
helper can consume instead?

Separately, values above 0xffff now come back as -ERANGE from kstrtou16()
rather than the -EINVAL that the removed check produced:

-	if (val > 0xffff)
-		return -EINVAL;

Could the commit message mention the new 18-byte input limit and the errno
change, since it currently describes the change only as a way to
"simplify 'tp_la_write()'"?
-- 
pw-bot: cr
